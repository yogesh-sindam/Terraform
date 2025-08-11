# Terrafrom-documents.
```
1 basic
2 modulerization 
3 remote backend
4 state locking 
5 provisioners
6 local-exec, remote-exec
```
## Important terraform commands
```
terraform init - to initialize
terraform plan - to dry run or a basic execution check that plan can able to apply
terraform apply - apply the changes on provider 
terraform apply --auto-approve - to skip manual acceptence which applying the plan
terraform import import one module to  current working
terraform fmt - formating, removes extra whitspace, maintian a syntax like open bracket will be closed
terraform state module_name - to see the module specification
terraform state list - see all the module
terraform state rm - remove a module from statefile
terraform destory
plan and destroy target specific resource
terraform plan -target=module
terraform apply -target=module
terraform destory -target=module
terraform taint resource_name.resource_locak_name  # destroy and create the resource


```
Drift detection between code and actual infra
run `Terraform plan` regularly using `scheduler`, use cicd






