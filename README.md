# Jit Security Helm Charts

This repository contains Helm charts for Jit Security's Kubernetes applications.

## Charts

### [jit-k8s-agent](charts/jit-k8s-agent)
A Kubernetes resource collector that periodically gathers cluster resource information and uploads it to Jit.

## Usage

[Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
helm repo add jitsecurity https://jitsecurity.github.io/helm-charts
helm repo update
```

You can then run `helm search repo jitsecurity` to see the available charts.