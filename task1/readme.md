New customer signs up
    ↓
Add their name to tenants.yaml file
    ↓
GitHub Actions workflow runs automatically
    ↓
Everything created in seconds


tenants:
   acme       # Existing customer
   shopify    # New customer added here

Terraform creates:
   Database: shopify_db
   User: shopify_user
   Password: (random secure)

Kubernetes creates:
   Namespace: shopify
   ServiceAccount: shopify-sa
   Role: shopify-role
   RoleBinding: connects SA to Role


Run 1: Create database for acme
  

Run 2: Run workflow again for acme , nothing changes 
    
Run 3: Run workflow again for acme, Still already exists, nothing changes

No duplicates! No problems! ✓

before 1 tenant 
tenants:
  -acme

after 50 tenant 
  -acme
  -shopify
  -stripe
  -google
  -apple


1 tenant? Loop runs 1 time
50 tenants? Loop runs 50 times
1000 tenants? Loop runs 1000 times
