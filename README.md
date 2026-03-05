# Terrafrom-documents
```
1 Basics
2 modulerization 
3 remote backend
4 state locking (Dynamodb)
5 provisioners
6 local-exec, remote-exec these are combined used with null_resource
7 null resource[ no action resource ]
  best use of null resource with provisioners

```
## Important terraform commands
```
terraform init - to initialize .
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
workspace will help to create resource in multiple env/account 
terraform workspace show [to check the workspace]
terraform workspace new workspace_name [new workspace]
terraform workspace list [list of all workspcaes]
terraform workspace select workspace_name [to select a workspace]
terraform workpace delete workspace_name
terraform plan -refresh-only # since refresh is being deprecated form version 1.9 >
terraform plan -refresh-only # shows actual infra vs present state file
terraform apply -refresh-only # update the statefile with actual infra
terraform plan/apply -refresh-only --target=module.
terraform init --plugin-dir="c:/user/Appdata/roaming/provider/" # user exist provider to init so the file cant download it form terraform.io, is use already existed in local by providing plugin_dir

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
use terraform workspace, it will manage state file according to environment.

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

Here are 𝟏𝟓 𝐚𝐝𝐯𝐚𝐧𝐜𝐞𝐝, 𝐫𝐞𝐚𝐥-𝐰𝐨𝐫𝐥𝐝 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐪𝐮𝐞𝐬𝐭𝐢𝐨𝐧𝐬 you must be ready for

1. How do you design a 𝐦𝐮𝐥𝐭𝐢-𝐚𝐜𝐜𝐨𝐮𝐧𝐭 𝐀𝐖𝐒 𝐬𝐞𝐭𝐮𝐩 with shared modules and centralized state management?
2. What’s your strategy to 𝐦𝐚𝐧𝐚𝐠𝐞 𝐩𝐫𝐨𝐯𝐢𝐝𝐞𝐫 𝐯𝐞𝐫𝐬𝐢𝐨𝐧 𝐝𝐫𝐢𝐟𝐭 across multiple repos and teams?
3. How do you handle 𝐜𝐫𝐨𝐬𝐬-𝐫𝐞𝐠𝐢𝐨𝐧 𝐝𝐞𝐩𝐞𝐧𝐝𝐞𝐧𝐜𝐢𝐞𝐬 (like S3 replication or RDS read replicas) in Terraform?
4. How do you implement 𝐳𝐞𝐫𝐨-𝐝𝐨𝐰𝐧𝐭𝐢𝐦𝐞 𝐝𝐞𝐩𝐥𝐨𝐲𝐦𝐞𝐧𝐭𝐬 using Terraform?
5. How would you 𝐫𝐞𝐟𝐚𝐜𝐭𝐨𝐫 𝐚 𝐦𝐨𝐧𝐨𝐥𝐢𝐭𝐡𝐢𝐜 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐫𝐞𝐩𝐨 into modular stacks for scalability?
6. How do you secure and lock the 𝐬𝐭𝐚𝐭𝐞 𝐟𝐢𝐥𝐞 when multiple users collaborate via S3 + DynamoDB?
7. How do you enforce 𝐜𝐨𝐦𝐩𝐥𝐢𝐚𝐧𝐜𝐞 𝐚𝐧𝐝 𝐠𝐨𝐯𝐞𝐫𝐧𝐚𝐧𝐜𝐞 using Sentinel or OPA with Terraform Cloud?
8. What’s your approach to 𝐦𝐢𝐠𝐫𝐚𝐭𝐢𝐧𝐠 𝐟𝐫𝐨𝐦 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐎𝐒𝐒 𝐭𝐨 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐂𝐥𝐨𝐮𝐝 with minimal disruption?
9. How do you integrate 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐢𝐧𝐭𝐨 𝐂𝐈/𝐂𝐃 𝐩𝐢𝐩𝐞𝐥𝐢𝐧𝐞𝐬 for environment promotions (dev → prod)?
10. How do you manage 𝐬𝐞𝐜𝐫𝐞𝐭 𝐫𝐨𝐭𝐚𝐭𝐢𝐨𝐧 𝐚𝐧𝐝 𝐢𝐧𝐣𝐞𝐜𝐭𝐢𝐨𝐧 using Vault or AWS Secrets Manager?
11. How do you perform 𝐢𝐧𝐟𝐫𝐚 𝐜𝐡𝐚𝐧𝐠𝐞𝐬 𝐰𝐢𝐭𝐡𝐨𝐮𝐭 𝐝𝐨𝐰𝐧𝐭𝐢𝐦𝐞 - especially for autoscaling or load balancers?
12. How do you 𝐭𝐞𝐬𝐭 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐜𝐨𝐝𝐞 for logic, drift, and policy compliance?
13. How do you design a 𝐦𝐮𝐥𝐭𝐢-𝐜𝐥𝐨𝐮𝐝 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐬𝐞𝐭𝐮𝐩 (AWS + Azure + GCP) with shared modules?
14. How do you ensure 𝐢𝐝𝐞𝐦𝐩𝐨𝐭𝐞𝐧𝐜𝐲 and prevent unwanted re-creations during apply?
15. How do you design 𝐛𝐥𝐮𝐞-𝐠𝐫𝐞𝐞𝐧 𝐨𝐫 𝐜𝐚𝐧𝐚𝐫𝐲 𝐢𝐧𝐟𝐫𝐚𝐬𝐭𝐫𝐮𝐜𝐭𝐮𝐫𝐞 𝐫𝐨𝐥𝐥𝐨𝐮𝐭𝐬 using Terraform and pipelines?

```
## Enforce resource deletion method on terraform code
```
resource "aws_db_instance" "main" {
  ...
  deletion_protection = true
}
# even terraform try to destroy -> aws block it
```

