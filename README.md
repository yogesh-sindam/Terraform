 # Terrafrom-documents.
```
1 basic
2 modulerization 
3 remote backend
4 state locking (Dynamodb)
5 provisioners
6 local-exec, remote-exec
7 null resource[ no action resource ]
  best use of null resource with provisioners 

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
terraform taint resource_name.resource_local_name  # destroy and create the resource
terraform refresh # refresh the state file with actual state
terraform refresh --target=moudle.aws_instance.loacl_name ## we can refresh module by targeting 
terraform workspace show [to check the workspace]
terraform workspace new workspace_name [new workspace]
terraform workspace list [list of all workspcaes]
terraform workspace select workspace_name [to select a workspace]
terraform workpace delete workspace_name
terraform plan --refresh-only # since refresh is being deprecated form version 1.9 >
terraform apply --refresh-only

```

Drift detection between code and actual infra
run `Terraform plan` regularly using `scheduler`, use cicd 
terraform refresh [outputs are automatically update state file]
###@@


##



