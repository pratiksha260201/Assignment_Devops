# Tenant Provisioning Flow

## How It Works

```text
New customer signs up
        ↓
Add customer name to tenants.yaml
        ↓
GitHub Actions workflow runs
        ↓
Resources are created automatically
```

## tenants.yaml

```yaml
tenants:
  - acme
  - shopify
```

## Terraform Creates

```text
Database:      shopify_db
User:          shopify_user
Password:      Random secure password
```

## Kubernetes Creates

```text
Namespace:        shopify
ServiceAccount:   shopify-sa
Role:             shopify-role
RoleBinding:      shopify-rolebinding
```

## Idempotency

```text
Run 1:
Resources created for acme

Run 2:
Workflow runs again
No changes

Run 3:
Workflow runs again
Resources already exist

Result:
No duplicate resources
```

## Scaling

### Before

```yaml
tenants:
  - acme
```

### After

```yaml
tenants:
  - acme
  - shopify
  - stripe
  - google
  - apple
```

## Loop Example

```text
1 tenant     → Loop runs 1 time
50 tenants   → Loop runs 50 times
1000 tenants → Loop runs 1000 times
```
