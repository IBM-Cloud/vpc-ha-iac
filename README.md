# Overview

This repository aims to provide various samples of infrastructure as code (IAC) in the
form of terraform scripts for setting up resilient infrastructure on IBM Cloud VPC. The terraform
scripts offer developers, DevOps, or system administrators an automated way to set up a
resilient 3-tier application with Intel Xeon processors on IBM Cloud Virtual Private Cloud (VPC).
While there is no one size fit, the intent is to provide example codes for different use cases that
can be used either as an educational tool or framework to build the resilient infrastructure. It is
expected that you will need to modify the code to adapt to your business or application requirements.

Pre-Requisite:

- IBM Cloud account
- API Key
- Knowledgeable with IBM Cloud VPC
- Knowledgeable with Terraform
- Machine with Terraform package

Does NOT:

- Install software packages for Use case 1-3
- Setup replication on the db
- Create snapshots

## Use 1: 3 Tier application (stateless)

<img src="./3-tier-stateless/images/3-tier-app-MZR_v3.jpg" width="400" />

Setting up a resilient infrastructure for a 3-tier application (web, app, and db) in a single MZR.
Each tier will span across the 3 different availability zones. Every tier, the VSIs are created
across the other availability zones to protect against a single point of failure against
component and availability zone.

In addition, the following are created:

- All VSIs are private only and should be linux
- Application load balancer for all 3 tiers to distribute traffic to healthy VSIs.
- Security groups to limit communication within a tier and with adjacent tier
- Bastion server with a public interface and should be linux

## Use 2: 3 Tier application with autoscale

Use Case 2 builds off of Use Case 1 and includes a compute feature, autoscale, for a single MZR.
Autoscale provides horizontal scaling of VSIs based on the current load. You set up a scaling
policy that defines the minimum and maximum range for the number of VSIs. You add and pay for
what you need, and delete and save when the load demand is lower. Autoscale is set up for the
web and app tier.

Note: It is recommended to build a golden image that autoscale can fork from. Otherwise, when
using the base image, user-data or post-install scripts are required to build the VSI.

## Use 3: Multi-region

<img src="./multi-region/images/multi-region-3-tier-autoscale-mzr.png" width="400" />

For multi-region, it takes the Use Case 2 and replicates the same infrastructure setup for a
2nd MZR for active-active. Resiliency is typically within an MZR, but the second region does
provide protection against region failure.

Additional elements are added for multi-region

- Transit gateway for cross-region communication/management
- Cross-region COS
- Cloud Internet Services (CIS)/global load balancer
- Subnet gateway

## Automation Use Cases

This installs the following software packages, Wordpress, Apache, PHP, and Maria db.

<img src="./single-availability-zone-automation/images/Software-stack.png" width="250" />

You can modify, add or change to different software packages as needed by simply modifying the
userdata. The userdata can be found in instance_group module of the tf file for app and web.
For db, the tf file is located in the instance module.

This uses the same infrastructure described in the aforementioned above sections, 3-tier with
autoscale (MZR) and cross-MZR.

### Single Availability Zone

This use case is for applications that are deployed in a single availability zone. Resources do
not expand the single availability zone. Placement groups improve resiliency by ensuring that
VSIs are created in different compute host/hypervisor.

### DB

Replication is not part of the terraform automation code and thus needs to be configured and set up
as a post-install. More information for maria replication overview can be found [here](https://mariadb.com/kb/en/standard-replication/).

In addition, for additional resiliency measure, you can do snapshots of the db as backup. To create
a bash/cron job for regular backup cadence can be found [here](https://www.ibm.com/cloud/blog/automate-the-backup-and-restore-of-cloud-instances-with-snapshots).

# Suggestion/Issues

While there are no warranties of any kind, and there is no service or technical support available
for these scripts from IBM support, your comments are welcomed by the maintainers and developers,
who reserve the right to revise or remove the tools at any time. We, maintainers and developers,
will support the scripts posted in this repository. Please open a GitHub issue to report problems
and provide suggestions or comments. If the scripts are modified and have issues, we will do our
best to assist.

## Known Issues
* Private VSIs deployed with RHEL 7.9 may not be able to resolve to an internal IBM satellite yum repo.
As a workaround deployed a subnet gateway and point to an external RHEL repo.
* In rare cases, terraform destroy does not delete all VSIs that are part of placement groups, single
availability zone use case. In these cases, manual deletion is required.
