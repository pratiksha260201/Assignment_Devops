Each customer has their OWN password vault

Netflix              Stripe               Google
┌──────────────┐  ┌──────────────┐   ┌──────────────┐
│ Netflix pwd  │  │ Stripe pwd   │   │ Google pwd   │
└──────────────┘  └──────────────┘   └──────────────┘

If Netflix gets hacked:
   Netflix password leaked
   Stripe password safe
   Google password safe

Only 1 customer affected, others protected!

Netflix pod  →  "I am netflix-sa"  →  GCP verifies  →  access granted
                                        ↓
                                   stripe-sa?  →  rejected




When a pod is compromised, the attacker inherits whatever permissions that pod's service account holds. If the service account has a broad project-level role like Editor, the attacker can read every secret in the project — every tenant's passwords and API keys in one sweep. By binding the service account only to a single secret (e.g. jio-hotstar), the blast radius shrinks to just that one tenant. The attacker cannot request 'jio-hotstar' or 'google-secret` because GCP will reject the call outright — the identity simply has no permission to access them.



NetworkPolicy controls which pods can open TCP connections to which other pods. It does nothing about the secret store. A Netflix pod blocked from reaching the Stripe database can still make an API call to GCP Secret Manager and pull the Stripe secret — if the IAM binding allows it. Network rules and IAM rules protect different things: one governs traffic between workloads inside the cluster, the other governs access to cloud resources outside it. Relying on only one means a gap in the other goes undefended. Both layers need to be in place so that even if an attacker finds a way around one, the other still holds.


