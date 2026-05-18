# Multi Tenant Infrastructure Setup

This project automates tenant onboarding, secret management, Kubernetes access, and infrastructure monitoring using Terraform, Kubernetes, GitHub Actions, GCP Secret Manager, and ArgoCD.

---

# Task 1 - Tenant Provisioning

## Flow

```text
New customer added
        ↓
Add tenant name in tenants.yaml
        ↓
GitHub Actions workflow starts
        ↓
Terraform creates database and user
        ↓
Kubernetes creates namespace and RBAC
```

---

## tenants.yaml

```yaml
tenants:
  - acme-corp
  - shopify
```

---

## Terraform Creates

```text
Database: acme_corp_db
User: acme_corp_user
Password: Random password
```

---

## Kubernetes Creates

```text
Namespace: acme-corp
ServiceAccount: acme-corp-sa
Role: Read-only secret access
RoleBinding: Connects role and service account
```

---

## Idempotency

Workflow can run many times safely.

```text
Run 1:
Resources created

Run 2:
Resources already exist
No changes

Run 3:
Runs safely again
No duplicate resources
```

---

## Multiple Tenants

```yaml
tenants:
  - acme-corp
  - shopify
  - stripe
  - google
```

```text
1 tenant → loop runs 1 time
50 tenants → loop runs 50 times
100 tenants → loop runs 100 times
```

No workflow changes are needed for more tenants.

---

# Task 2 - Secret Isolation & Security

## Separate Secret for Each Tenant

```text
tenant-acme-corp-credentials
tenant-shopify-credentials
tenant-google-credentials
```

Each tenant has its own secret.

---

## Workload Identity

Each Kubernetes ServiceAccount gets access only to its own secret.

```text
acme-corp-sa → acme-corp secret
shopify-sa → shopify secret
```

If one pod is hacked, other tenant secrets stay safe.

---

## External Secret Flow

```text
GCP Secret Manager
        ↓
ExternalSecret
        ↓
Kubernetes Secret
```

Secrets sync automatically into Kubernetes.

---

## Network Policy

Tenant pods can connect only to:

```text
1. Cluster DNS
2. Their own database
```

All other traffic is blocked.

---

## Why Secret-Level Access Is Important

If one service account has access to all secrets, a hacked pod can read every tenant password.

With separate access:

```text
Netflix pod hacked
        ↓
Can read only Netflix secret
        ↓
Cannot access Stripe or Google secrets
```

---

## Why NetworkPolicy Alone Is Not Enough

NetworkPolicy blocks pod traffic inside Kubernetes.

But pods can still access cloud services if IAM permissions allow it.

```text
NetworkPolicy → controls pod traffic
IAM → controls cloud resource access
```

Both are needed for security.

---

# Task 3 - Infra Change Visibility

## PR Diff Workflow

GitHub Actions runs on every PR.

```text
1. Build manifests from main branch
2. Build manifests from PR branch
3. Compare both outputs
4. Add diff in PR comment
```

---

## Example

Developer accidentally deletes:

```text
admin-dashboard-service.yaml
```

PR comment shows:

```text
REMOVED:
Service: admin-dashboard-service
Kind: Service
```

Developer fixes the mistake before merge.

---

## ArgoCD Alerts

Slack alert is sent when application becomes:

```text
Degraded
OutOfSync
```

Alert includes:

```text
Application name
Environment
ArgoCD link
```

This helps quickly detect deployment issues.

---

# Tools Used

```text
Terraform
Kubernetes
GitHub Actions
PostgreSQL
GCP Secret Manager
Workload Identity
External Secrets Operator
ArgoCD
Kustomize
Slack
```
