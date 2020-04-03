```
// format
$ terraform fmt
$ terraform fmt -recursive
// preview
$ terraform plan
// apply
$ terraform apply
// destroy
$ terraform destroy
// validate
$ terraform validate
// graph
$ terraform graph | dot -Tpng > graph.png
// get module
$ terraform get
// indicate variable value
$ terraform plan -var 'environment=dev'
// using variable files
terraform plan -var-file=./development.tfvars
```
