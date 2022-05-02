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

Control syntax

```bash
tf validate
```

Control resources plan

```bash
tf plan
```

Execute installation

```bash
tf apply --auto-approve
```

Wait to let perform the couchbase nodes installation, configuration and peering
Copy outputs couchbase nodes URI, or ssh connexion.
Play with couchbase server (import data, failover, add/removes nodes )
Destroy the staging environement when finished

```bash
tf destroy --auto-approve
```
