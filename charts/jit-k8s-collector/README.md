# Jit Kubernetes Collector

A robust Kubernetes resource collector that periodically gathers cluster resource information and uploads it to JIT service. This tool helps maintain an up-to-date inventory of your Kubernetes resources across different environments.


## Prerequisites

* Kubernetes cluster access
* JIT service credentials
* Helm 3.x (for deployment)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:
```
  helm repo add jitsecurity https://jitsecurity.github.io/helm-charts
  helm repo update
  helm install jit-k8s-collector --set jit.clientId=<CLIENT_ID> --set jit.clientSecret=<CLIENT_SECRET> --set cluster.name=<CLUSTER_NAME> -n jit-k8s-collector --create-namespace jitsecurity/jit-k8s-collector
```

To uninstall the chart:
```
  helm uninstall jit-k8s-collector
```

## Configuration

The following table lists the configurable parameters of the `jit-k8s-collector` chart and their default values.

| Parameter                  | Description                                      | Default                                      |
|----------------------------|--------------------------------------------------|----------------------------------------------|
| `image.repository`         | Image repository                                 | `ghcr.io/jitsecurity/jit-k8s-collector`      |
| `image.tag`                | Image tag                                        | `0.1.0`                                      |
| `image.pullPolicy`         | Image pull policy                                | `IfNotPresent`                               |
| `cluster.name`             | Name of the cluster (required)                   | `""`                                         |
| `jit.clientId`             | JIT service client ID (required)                 | `""`                                         |
| `jit.clientSecret`         | JIT service client secret (required)             | `""`                                         |
| `jit.apiUrl`               | JIT service API URL                              | `https://api.jit.io`                         |
| `serviceAccount.name`      | Name of the service account                      | `jit-k8s-collector-sa`                       |
