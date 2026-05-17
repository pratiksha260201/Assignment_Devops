

Developer Alice accidentally deletes admin-dashboard-service.yaml

rm kubernetes/services/admin-dashboard-service.yaml

crteate PR 
git add .
git commit -m "Remove unused service"
git push

developer accidentally deleted a service file"



GitHub Actions runs automatically
  
Workflow builds manifests from main:
  admin-dashboard-service exists

Workflow builds manifests from PR:
  admin-dashboard-service MISSING

Comparison:
  REMOVED: Service admin-dashboard-service


  PR Comment (shows automatically):


how the Diff on PR

 REMOVED:
  Service: admin-dashboard-service
  Kind: Service
  

This looks like a critical service!

Change removed from PR
Code merged safely
Deployed to production
