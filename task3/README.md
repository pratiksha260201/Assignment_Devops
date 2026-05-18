# PR Diff Check Flow

## Accidental File Deletion

```text
Developer deletes a service file

rm kubernetes/services/admin-dashboard-service.yaml
```

---

# Create PR

```text
git add .
git commit -m "Remove unused service"
git push
```

Developer creates a Pull Request.

---

# GitHub Actions Runs Automatically

```text
Workflow checks files from main branch
```

Main branch:

```text
admin-dashboard-service exists
```

PR branch:

```text
admin-dashboard-service missing
```

---

# Diff Comparison

```text
REMOVED:
Service: admin-dashboard-service
Kind: Service
```

---

# Automatic PR Comment

```text
This looks like a critical service.
Please review before merging.
```

---

# Result

```text
Developer notices mistake
Service file restored
PR updated safely
Code merged
Deployment successful
```
