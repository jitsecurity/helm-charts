# Jit Kubernetes Collector

A robust Kubernetes resource collector that periodically gathers cluster resource information and uploads it to Jit service. This tool helps maintain an up-to-date inventory of your Kubernetes resources across different environments.


## Prerequisites

* Kubernetes cluster access
* Jit service credentials
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
| `cluster.name`             | Name of the cluster (required) `(1)`                  | `""`                                         |
| `jit.clientId`             | Jit service client ID (required) `(2)`                 | `""`                                         |
| `jit.clientSecret`         | Jit service client secret (required) `(2)`             | `""`                                         |
| `jit.apiUrl`               | Jit service API URL                              | `https://api.jit.io`                         |
| `serviceAccount.name`      | Name of the service account                     | `jit-k8s-collector-sa`                       |

`(1)` You can retrieve the cluster name by running `kubectl config get-clusters` or `kubectl config current-context`

`(2)` Refer to [Jit documentation](https://docs.jit.io/docs/managing-users#generating-api-tokens) for more information on how to get the client ID and secret.
