{{- define "jit-job-spec" -}}
{{- $jitCredentialsSecret := .Values.jit.existingSecret | default (printf "%s-jit-credentials" .Chart.Name) -}}
spec:
  serviceAccountName: {{ .Values.serviceAccount.name }}
  restartPolicy: OnFailure
  {{- if .Values.tolerations }}
  tolerations:
{{ toYaml .Values.tolerations | indent 4 }}
  {{- end }}
  {{- if .Values.nodeSelector }}
  nodeSelector:
{{ toYaml .Values.nodeSelector | indent 4 }}
  {{- end }}
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
              name: {{ $jitCredentialsSecret }}
              key: JIT_CLIENT_ID
        - name: JIT_CLIENT_SECRET
          valueFrom:
            secretKeyRef:
              name: {{ $jitCredentialsSecret }}
              key: JIT_CLIENT_SECRET
        - name: JIT_API_URL
          value: {{ .Values.jit.apiUrl }}
        - name: KUBESCAPE_ENABLED
          value: "{{ .Values.kubescape.enabled }}"
{{- end -}}
