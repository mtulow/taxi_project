# <center> Infrastructure-as-Code via Terraform </center>
---

Architectures:
- 

## <center> How to deploy AWS Redshift Cluster using Terraform </center>
Source: [How to deploy AWS Redshift Cluster using terraform](https://blog.knoldus.com/how-to-deploy-aws-redshift-cluster-using-terraform/)

---
---
---

## <center> AWS ECS Deployment Architecture </center>

### Overview
The most common AWS deployment of Mage is with AWS ECS. Our Terraform scripts manage the process of creating an ECS cluster, a load balancer, and a database. [Here’s a link](https://docs.mage.ai/production/deploying-to-cloud/aws/resources) to the default output of `terraform plan` on AWS ECS.

![](https://github.com/mage-ai/assets/blob/main/architecture/aws-ecs.png?raw=True)

We use the following AWS services in our deployment:

---

### Elastic Container Service (ECS)
Amazon ECS is a service provided by AWS for managing and deploying containerized applications. The ECS service in Terraform is used to define and configure the ECS clusters and services.

ECS allows you to run containers at scale, and the Terraform configuration for ECS service includes specifying the task definition, desired task count, launch type, and other settings related to container orchestration.

The Mage application runs as multiple containers in an Amazon ECS service.

---

### Application Load Balancer (ALB)
An Application Load Balancer is a service provided by AWS that distributes incoming application traffic across multiple targets, such as EC2 instances, ECS containers, or Lambda functions.

In Terraform, the ALB resource is used to define and configure the load balancer, including listeners, target groups, and rules for routing incoming requests to the appropriate backend targets.

Our ALB is configured to route traffic to the ECS cluster and provides a public URL for communication with clients. Read more [here](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-ip-address-type.html).

---

### Elastic File System (EFS)
Amazon EFS provides a fully managed, scalable, and shared file storage service that can be used with AWS services and on-premises resources.

We use EFS to store a persistent volume where the `mage_data` for your project is stored. You can learn more about what is stored in `mage_data` [here](https://docs.mage.ai/design/abstractions/project-structure#project-data). Without EFS, your project data would be lost when your ECS service is terminated. EFS allows us to persist data between containers within ECS.

---

### Relational Database Service (RDS)
The RDS Instance resource is used to define and configure a specific database instance within the Amazon RDS service.

We use a Postgres RDS to hold the the backend database for your Mage instance. This database contains the metadata that powers Mage. Read more [here](https://docs.mage.ai/design/abstractions/project-structure#project-data).

---

### Virtual Private Cloud (VPC)
Amazon VPC allows you to create a virtual network within AWS, enabling you to isolate and control resources in a private, logically isolated section of the AWS cloud.

The VPC resource in Terraform is used to define and configure the virtual network, including its subnets, route tables, security groups, and other networking-related settings.

The Mage application, ALB, ECS, EFS, and RDS are all deployed within a VPC in our Terraform scripts.

---
---

## Terraform Files
- [`alb.tf`](#albtf)
- [`db.tf`](#dbtf)
- [`efs.tf`](#efstf)
- [`iam.tf`](#iamtf)
- [`lambda.tf`](#lambdatf)
- [`vpc.tf`](#vpctf)
- [`networking.tf`](#networkingtf)
- [`main.tf`](#maintf)
- [`outputs.tf`](#outputstf)
- ...

---

### `alb.tf`

| Resources | ... | ... |
|---|---|---|
| `aws_alb` | `application_load_balancer` | ... |
| `aws_security_group` | `load_balancer_security_group` | ... |
| `aws_lb_target_group` | `target_group` | ... |
| `aws_lb_listener` | `listener` | ... |
| `http` | `ip` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `efs.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_efs_file_system` | `file_system` | ... |
| `aws_efs_mount_target` | `mount_target` | ... |
| `aws_security_group` | `mount_target_security_group` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `db.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_db_instance` | `rds` | ... |
| `aws_db_subnet_group` | `rds_subnet_group` | ... |
| `aws_security_group` | `rds_sg` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `iam.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_iam_role` | `ecsTaskExecutionRole` |  |
| `aws_iam_policy` | `ecsTaskExecutionRole_policy` |  |
| `aws_iam_role` | `lambda_role` |  |
| `aws_iam_policy` | `iam_policy_for_lambda` |  |
| `aws_iam_role` | `redshift_role` |  |
| `aws_iam_policy` | `iam_policy_for_redshift` |  |
| `aws_iam_role_policy_attachment` | `attach_iam_policy_to_lambda_role` |  |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `lambda.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_lambda_function` | `terraform_lambda_func` | ... |
| `archive_file` | `zip_the_python_code` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `vpc.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_vpc` | `aws-vpc` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `networking.tf`

| Resources | Name | ... |
|---|---|---|
| `aws_internet_gateway` | `aws-igw` | ... |
| `aws_subnet` | `public` | ... |
| `aws_subnet` | `private` | ... |
| `aws_route_table` | `public` | ... |
| `aws_route_table_association` | `public` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `main.tf`

| Resources | Name | ... |
|---|---|---|
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### `main.tf`

| Resources | Name | ... |
|---|---|---|
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

| Resources | Name | ... |
|---|---|---|
| `...` | `...` | ... |
| `...` | `...` | ... |
| `...` | `...` | ... |

[back to top](#terraform-files)

---

### Read More

You can refer to the instructions found here to learn more about deploying to ECS.

---
---
---