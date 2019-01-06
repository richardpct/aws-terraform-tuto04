# Purpose
I will show you how to build a scenario more complex than the previous one
using public and private subnet in the same VPC.
The scenario takes up this tutorial
[Scenario 2: VPC with Public and Private Subnets (NAT)](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html?shortFooter=true),
here are the components you will build:

* Creating a VPC with a public subnet and a private subnet
* Creating a webserver in the public subnet, this is the only that can be
reachable from the internet via SSH. For this example I wrote a Go
[program](https://github.com/richardpct/go-example-tuto04) which spins up a webserver
* Creating a database server using Redis which stores the count of requests,
only the webserver is allowed to connect to the database server using firewall rules called "Security Group"
* Creating a NAT gateway with an Elastic IP (EIP) in order to reach Internet
by the database which is in the private subnet

Notice: For this example I do not use "Elastic Cache" feature provided by AWS,
instead I use an EC2 instance and I install Redis manually.

# Requirement
* You must have an AWS account, if you don't have yet, you can subscribe to the free tier.
* You must install terraform

# Usage
## Exporting the required variables in your terminal:
    $ export TF_VAR_region="eu-west-3"
    $ export TF_VAR_bucket="my-terraform-state"
    $ export TF_VAR_dev_network_key="terraform/dev/network/terraform.tfstate"
    $ export TF_VAR_dev_database_key="terraform/dev/database/terraform.tfstate"
    $ export TF_VAR_dev_webserver_key="terraform/dev/webserver/terraform.tfstate"
    $ export TF_VAR_ssh_public_key="ssh-rsa ..."
    $ export TF_VAR_dev_database_pass="redispasswd"
    $ export TF_VAR_my_ip_address=xx.xx.xx.xx/32

## Creating the S3 backend to store the terraform state if it is not already done
If you have not created a S3 backend, see my first tutorial
[https://github.com/richardpct/aws-terraform-tuto01](https://github.com/richardpct/aws-terraform-tuto01)

## Creating the VPC, subnet and security group
    $ cd environment/dev/01-network
    $ ./terraform_init.sh (execute this command once)
    $ terraform apply

## Creating the database
    $ cd ../02-database
    $ ./terraform_init.sh (execute this command once)
    $ terraform apply

## Creating the webserver
    $ cd ../03-webserver
    $ ./terraform_init.sh (execute this command once)
    $ terraform apply

## Testing your page
Open your web browser with the IP address of your webserver that is displayed previously

## Creating the staging environment
Repeat the same steps as previously by using the staging directory instead the dev directory

## Cleaning up
Choose your environment by entering in dev, staging or prod directory

    $ cd ../03-webserver
    $ terraform destroy
    $ cd ../02-database
    $ terraform destroy
    $ cd ../01-network
    $ terraform destroy
