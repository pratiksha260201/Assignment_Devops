# Secret Isolation Between Tenants

## Separate Secrets for Each Customer

```text
Netflix              Stripe               Google
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ Netflix pwd  │    │ Stripe pwd   │    │ Google pwd   │
└──────────────┘    └──────────────┘    └──────────────┘
```

If Netflix gets hacked:

```text
Netflix password leaked
Stripe password safe
Google password safe
```

Only one customer is affected.

---

# Service Account Access

```text
Netflix pod
      ↓
"I am netflix-sa"
      ↓
GCP verifies identity
      ↓
Access granted

Trying stripe-sa secret?
      ↓
Access denied
```

---

# Why Single Secret Access Is Important

If a pod is hacked, the attacker gets the permissions of that pod’s service account.

Bad example:

```text
One service account has access to all secrets
```

Result:

```text
Attacker can read passwords of all customers
```

Better approach:

```text
Each service account can access only its own secret
```

Result:

```text
Netflix pod → Only Netflix secret
Stripe pod  → Only Stripe secret
Google pod  → Only Google secret
```

This reduces the impact of an attack.

---

# Why NetworkPolicy Alone Is Not Enough

NetworkPolicy controls pod-to-pod traffic inside Kubernetes.

Example:

```text
Netflix pod cannot connect to Stripe database
```

But:

```text
It can still call GCP Secret Manager
```

If IAM permission exists, it can still read Stripe secrets.

---

# Final Security Layer

```text
NetworkPolicy → Controls network traffic
IAM Rules     → Controls secret access
```

Both are needed for proper tenant isolation and security.
