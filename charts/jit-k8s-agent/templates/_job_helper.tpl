{{- define "jit-job-spec" -}}
spec:
  serviceAccountName: {{ .Values.serviceAccount.name }}
  restartPolicy: OnFailure
  containers:
    - name: jit-k8s-agent
      image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      resources:
        requests:
          cpu: {{ .Values.resources.requests.cpu }}
          memory: {{ .Values.resources.requests.memory }}
        limits:
          cpu: {{ .Values.resources.limits.cpu }}
          memory: {{ .Values.resources.limits.memory }}
      env:
        - name: CLUSTER_NAME
          value: {{ .Values.cluster.name }}
        - name: JIT_CLIENT_ID
          valueFrom:
            secretKeyRef:
              name: {{ .Chart.Name }}-jit-credentials
              key: JIT_CLIENT_ID
        - name: JIT_CLIENT_SECRET
          valueFrom:
            secretKeyRef:
              name: {{ .Chart.Name }}-jit-credentials
              key: JIT_CLIENT_SECRET
        - name: JIT_API_URL
          value: {{ .Values.jit.apiUrl }}
        - name: KUBESCAPE_ENABLED
          value: "{{ .Values.kubescape.enabled }}"
{{- end -}}
