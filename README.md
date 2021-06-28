# Overview
This repository is dedicated in providing sample infrastructure as code (IAC) int the form of
terraform scripts for setting up resilient infrastructure on IBM Cloud VPC. The terraform scripts
provide an automated way for developers, DevOps, or system administrators to set up a resilient 3-tier
application on IBM Cloud Virtual Private Cloud (VPC). While there is no one size fit all, the intent
behind the codes to provide sample codes for different use cases. You can modify the code to adapt to
your business/application requirements.
 
## Use 1: 3 Tier application (stateless)
3-tier application (web, app, and db) created in a single MZR. Each tier is front-end with an
application load balancer. Each tier has 3 static VSIs distributed across 3 zones. In addition, to
the VSIs security groups, and bastion server is created as part of the automation code.

## Use 2: 3 Tier application with autoscale
This use case is similar to Use 1 case which incorporates a compute feature, auto-scale for the web
and app tier VSIs. Autoscale dynamically scales horizontally up and down based on the desired load of
the compute resources.

# Suggestion/Issues
While there are no warranties of any kind, and there is no service or technical support available
for these scripts from IBM support, your comments are welcomed by the maintainers and developers,
who reserve the right to revise or remove the tools at any time. We, maintainers and developers,
will support the scripts posted in this repository. To report problems, provide suggestions or
comments, please open a GitHub issue. If the scripts are modified and have issues, we will do our
best to assist.
