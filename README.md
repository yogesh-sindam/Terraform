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
terraform plan -refresh-only # since refresh is being deprecated form version 1.9 >
terraform plan -refresh-only # shows actual infra vs present state file
terraform apply -refresh-only # update the statefile with actual infra 

```

Drift detection between code and actual infra
run `Terraform plan` regularly using `scheduler`, use cicd 
terraform refresh [outputs are automatically update state file]
###@@


##
```
These are the 20 most commonly asked Terraform questions—a must for anyone aiming for `Cloud Engineer or DevOps Engineer roles!`

1) What is Terraform, and how is it different from other Infrastructure as Code (IaC) tools like CloudFormation or Ansible?

2) Explain the concept of Terraform state. Where should it be stored securely?
to store state file securely, use remote state backend(s3) instead store in loacl or github.

3) What is the difference between terraform plan and terraform apply?

4) How do you manage secrets in Terraform?

5) What are Terraform providers? Can you create a custom one?

6) What is the role of terraform init?
ans- to initialize the terraform, and check the provider it download the module form terraform.io  

7) How do count, for_each, and dynamic blocks work in Terraform?
ans- count = how many required, for_each = same resource will in a loop unitl the list is completed 
8) What is the difference between local-exec and remote-exec provisioners?
local-exec in name is mention local execution, the executed , remote-executed(that newly provisioned ec2)

9) How do you perform Terraform state locking in a team environment?
using a dynamodb, conquer the error of executing parallal apply cmd.

10) What is terraform import used for? Any limitations?
resource is created on console, need to add in terraform state will not state, need to import the and update the state file 

11) How do you manage multiple environments (dev/stage/prod) in Terraform?
use terraform workspace, it will manage state file according to environment

12) What are Terraform workspaces, and when should you use them?
use terraform workspace, it will manage state file according to environment

13) Explain the difference between depends_on and implicit dependency.
depnds_on = resource will wait for the dependent resource will be created first and later it executed
implicit = one resource is inferred with another automatically

14) What are the best practices for writing reusable Terraform modules?
creating a common module and use for multiple environment.

15) Can two Terraform modules reference the same remote backend?
yes, all resource data will be stored in same state.file

16) How do you handle Terraform drifts?
while running terraform plan you can detect the changes outside, take decision accordingly

17) How do you integrate Terraform into a CI/CD pipeline?

18) What’s the difference between terraform taint and terraform destroy?
terraform taint - will destroy and create the resouce
terraform destroy - will destroy the resouce only

19) How to upgrade Terraform to a newer version safely in a production pipeline?
changes the configuration in terraform version = "1.10.13" --> "1.19.0"

20) Describe a real-world issue you faced with Terraform and how you resolved it.

```
