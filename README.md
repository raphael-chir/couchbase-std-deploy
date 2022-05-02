# Couchbase Cluster Setup

## Distributed in memory Data Platform

> This demo shows you how to automate Couchbase Server Cluster deployments in a **Cloud DevOps** approach with [Terraform](https://www.terraform.io/). Couchbase Cluster will be deploy on classical AWS IaaS, but can be deploy everywhere you want. For a fully managed solution, choose our **DBaaS** [Couchbase Capella 30-days Free Trial here](https://cloud.couchbase.com)

|               |                           |
| :------------ | :------------------------ |
| **data**      | Default mandatory service |
| **query**     | SQL++ query executor      |
| **index**     | Index storage             |
| **fts**       | Full text search engine   |
| **analytics** | Real Time analytics       |
| **eventing**  | Triggering service        |
| **backup**    | Full backup management    |

## Lab

![Labs](https://drive.google.com/uc?export=download&id=1byd5y0-3fmvf9BAl_uA1ufKp3EuWRLbb)

## Requirements

All utils tools is included in this demo sandbox :

- Terraform >= 1.1.7 (an alias tf is create for terraform cli)
- aws cli v2 (WARNING : you are responsible of your access key, don't forget to deactivate or suppress it in your aws account !)
- S3 bucket backend to store tf.state

## Project structure

My choice is to work online with CodeSandbox (fully vscode ide + NodeJS runtime environment + github sync), so cool as I am so lazy to install all on local. However this project can be clone from [https://github.com/raphael-chir/tf-couchbase](https://github.com/raphael-chir/tf-couchbase). Enjoy ...
Our terraform project is located inside **tf-playgroung** folder

```
tf-playground
+ modules
+ + compute # module on which instanciate Couchbase Nodes
+ + network # the baseline infrastructure on which deploy Couchbase nodes
+ scripts
+ + cluster-init.sh # first node installation and configuration script
+ + server-add.sh # other cluster nodes installation and configuration script
+ main.tf
+ outputs.tf
+ variables.tf
+ terraform.tfvars
```

All specific couchbase installation and configuration are handled by ec2 user-data mechanism. Other solutions can be implemented but it is not the purpose here.

## Playing

Open a terminal and check terraform CLI

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ terraform version
Terraform v1.1.7
on linux_amd64
```

Check aws cli

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ aws --version
aws-cli/2.6.1 Python/3.9.11 Linux/5.13.0-40-generic exe/x86_64.debian.10 prompt/off
```

Terraform state is stored on a S3 bucket, you need to configure your AWS access key. Don't forget to delete or deactivate your access key in IAM !

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ aws configure
AWS Access Key ID [None]: XXXXXXXXXXXXXX
AWS Secret Access Key [None]: XXXxxxxxxxxxxxxxxxxxXXXxxxxxxxxxXXxxxxxxx
Default region name [None]: eu-north-1
Default output format [None]:
```

Now it is time to initiate the terraform project, you should see :

```bash
sandbox@sse-sandbox-457lgm:/sandbox$ cd tf-playground/
sandbox@sse-sandbox-457lgm:/sandbox/tf-playground$ terraform init
Initializing modules...
- network in modules/network
- node01 in modules/compute
- node02 in modules/compute
- node03 in modules/compute
- node04 in modules/compute
- node05 in modules/compute

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v4.8.0...
- Installed hashicorp/aws v4.8.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Control syntax

```bash
terraform validate
```

Control resources plan

```bash
terraform plan
```

Execute installation

```bash
terraform apply -auto-approve
```

Wait to let perform the couchbase nodes installation, configuration and peering
Copy outputs couchbase nodes URI, or ssh connexion.
Play with couchbase server (import data, failover, add/removes nodes )
Destroy the staging environement when finished

```bash
terraform destroy --auto-approve
```
