# Jit Kubernetes Agent - Kubescape Integration Customer Summary

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
- **Runtime Toggle**: Set `KUBESCAPE_ENABLED=false` environment variable

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
- **Execution Time**: +3-5 seconds per scan *(for security analysis)*
- **Memory Usage**: +500MB-1GB during scanning
- **Additional Data**: Security findings uploaded to Jit dashboard

### **What Customers Will See**
1. **Same resource collection** as before
2. **New security findings** in Jit dashboard
3. **Slightly longer job execution** (3-5 seconds)
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

## 📞 **Customer Communication Template**

### **Email Subject**: "Action Required: Upgrade Jit Kubernetes Agent for Enhanced Security Scanning"

### **Key Points for Customers**:

1. **🎯 Value**: "Get automated security scanning alongside your existing resource monitoring"

2. **⏱️ Effort**: "2-minute upgrade with a single Helm command"

3. **🔄 Compatibility**: "Fully backward compatible - existing setup continues working"

4. **📈 Impact**: "Enhanced security insights with minimal performance impact"

5. **🛠️ Support**: "Our team is available to assist with the upgrade process"

### **Call to Action**:
> "Schedule your upgrade today to start receiving automated security findings in your Jit dashboard. Contact your Jit representative for assistance or to schedule a guided upgrade session."

---

## 📋 **GTM Talking Points**

### **For Prospects**:
- "Unified security and resource monitoring in one deployment"
- "NSA-framework security scanning out of the box"
- "Zero additional complexity - same simple Helm installation"

### **For Existing Customers**:
- "Enhanced value from your existing Jit investment"
- "Automated security scanning with no additional setup"
- "Backward compatible upgrade with rollback option"

### **Competitive Advantage**:
- "Integrated security + resource monitoring vs. separate tools"
- "One agent, comprehensive visibility"
- "Enterprise-grade security scanning included"

---

## 🎯 **Success Metrics**

Track customer adoption with:
- **Upgrade completion rate**
- **Security findings generated**
- **Customer satisfaction with new insights**
- **Reduction in separate security tool usage**
