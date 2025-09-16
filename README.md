# Jit Security Helm Charts

This repository contains Helm charts for Jit Security's Kubernetes applications.

## Charts

### [jit-k8s-agent](charts/jit-k8s-agent)
A Kubernetes resource collector with **Kubescape security scanning** that periodically gathers cluster resource information and security findings, uploading them to Jit.

## 🚀 **New Feature: Automated Security Scanning**

The Jit Kubernetes Agent now includes **Kubescape security scanning**, providing automated security assessments alongside existing resource collection.

---

## 📋 **What Existing Customers Need to Do**

### **Option 1: Simple Upgrade (Recommended - 2 minutes)**
```bash
# Update repository and upgrade
helm repo update jitsecurity
helm upgrade jit-k8s-agent jitsecurity/jit-k8s-agent -n jit-k8s-agent
```

### **Option 2: Fresh Installation (5 minutes)**
```bash
# If upgrade fails, clean reinstall
helm uninstall jit-k8s-agent -n jit-k8s-agent
helm install jit-k8s-agent \
  --set jit.clientId=<CLIENT_ID> \
  --set jit.clientSecret=<CLIENT_SECRET> \
  --set cluster.name=<CLUSTER_NAME> \
  -n jit-k8s-agent --create-namespace \
  jitsecurity/jit-k8s-agent
```

---

## ⚙️ **Configuration Options**

### **Enable/Disable Kubescape**
- **Default**: ✅ **Enabled** (automatic security scanning)
- **Disable**: `--set kubescape.enabled=false`
- **Configuration**: The Helm chart value `kubescape.enabled` is **authoritative** - it sets the `KUBESCAPE_ENABLED` environment variable in pod templates
- **Behavior Changes**: To toggle Kubescape on/off, use `helm upgrade` with the desired setting - changing environment variables on running pods has no effect without pod recreation

### **Resource Requirements Update**
- **Previous**: 1Gi memory requests / 2Gi limits
- **New**: 2Gi memory requests / 4Gi limits *(increased for security scanning)*

---

## 🎯 **Customer Benefits**

| Feature | Before | After |
|---------|--------|-------|
| **Resource Collection** | ✅ Kubernetes resources | ✅ Kubernetes resources |
| **Security Scanning** | ❌ Manual/separate tools | ✅ **Automated Kubescape NSA framework** |
| **Findings Integration** | ❌ Siloed security data | ✅ **Unified security + resource findings** |
| **Deployment Complexity** | Simple | **Same simplicity + security** |

---

## 📊 **Expected Changes**

### **Performance Impact**
- **Execution Time**: More seconds per scan *(for security analysis)*
- **Memory Usage**: +500MB-1GB during scanning
- **Additional Data**: Security findings uploaded to Jit dashboard

### **What Customers Will See**
1. **Same resource collection** as before
2. **New security findings** in Jit dashboard
3. **Longer job execution**
4. **Higher memory usage** during scans

---

## ✅ **Verification Steps**

After upgrade, customers should see:
```bash
kubectl logs -n jit-k8s-agent job/jit-k8s-agent-initial-job
```

**Success indicators:**
- ✅ `"Starting Kubescape security scan..."`
- ✅ `"Kubescape security scan completed"`
- ✅ `"Successfully uploaded Kubescape scan results"`
- ✅ `"Reported 2 upload paths"` *(instead of 1)*

---

## 🛡️ **Security & Compliance**

- **Framework**: NSA Kubernetes Hardening Guide
- **Version**: Kubescape v3.0.40 *(pinned for stability)*
- **Permissions**: No additional RBAC required
- **Data**: Encrypted uploads to existing S3 infrastructure

---

## 🔧 **Troubleshooting**

### **Common Issues & Solutions**

| Issue | Solution |
|-------|----------|
| **Memory pressure** | Ensure nodes have adequate resources or temporarily disable: `--set kubescape.enabled=false` |
| **Upgrade fails** | Use fresh installation option |
| **Scan errors** | Check logs and verify network connectivity |

### **Rollback Option**
```bash
helm rollback jit-k8s-agent -n jit-k8s-agent
```

---

## Usage

[Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
helm repo add jitsecurity https://jitsecurity.github.io/helm-charts
helm repo update
```

You can then run `helm search repo jitsecurity` to see the available charts.