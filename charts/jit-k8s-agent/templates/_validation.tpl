{{/*
Validate required values and provide clear error messages
*/}}
{{- define "jit-k8s-agent.validateValues" -}}
{{- $errors := list -}}

{{- if not .Values.cluster.name -}}
{{- $errors = append $errors "cluster.name is required and cannot be empty" -}}
{{- end -}}

{{- if .Values.jit -}}
  {{- if and .Values.jit.clientId .Values.jit.clientSecret -}}
    {{- if .Values.jit.existingSecret -}}
{{- $errors = append $errors "Cannot specify both direct credentials (clientId/clientSecret) and existingSecret. Choose one authentication method." -}}
    {{- end -}}
  {{- else if .Values.jit.existingSecret -}}
    {{- /* Valid: using existingSecret */ -}}
  {{- else -}}
{{- $errors = append $errors "Jit authentication requires either: 1) Both 'clientId' and 'clientSecret' for direct authentication, or 2) 'existingSecret' to reference an existing Kubernetes secret" -}}
  {{- end -}}
{{- else -}}
{{- $errors = append $errors "Jit configuration is required. Please provide either clientId/clientSecret or existingSecret" -}}
{{- end -}}

{{- if $errors -}}
{{- $errorMsg := printf "Configuration validation failed:\n" -}}
{{- range $errors -}}
{{- $errorMsg = printf "%s  • %s\n" $errorMsg . -}}
{{- end -}}
{{- $errorMsg = printf "%s\nExample configurations:\n" $errorMsg -}}
{{- $errorMsg = printf "%s  # Option 1: Direct credentials\n" $errorMsg -}}
{{- $errorMsg = printf "%s  jit:\n" $errorMsg -}}
{{- $errorMsg = printf "%s    clientId: \"your-client-id\"\n" $errorMsg -}}
{{- $errorMsg = printf "%s    clientSecret: \"your-client-secret\"\n" $errorMsg -}}
{{- $errorMsg = printf "%s\n  # Option 2: Existing secret\n" $errorMsg -}}
{{- $errorMsg = printf "%s  jit:\n" $errorMsg -}}
{{- $errorMsg = printf "%s    existingSecret: \"jit-credentials\"\n" $errorMsg -}}
{{- fail $errorMsg -}}
{{- end -}}
{{- end -}}