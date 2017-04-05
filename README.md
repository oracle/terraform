Terraform Provider for Oracle Compute Cloud
===========================================

PLEASE NOTE: This repository location has changed from github.com/oracle/terraform to [github.com/oracle/terraform-provider-compute](https://github.com/oracle/terraform-provider-compute/)

For the Terraform Provider for Oracle Bare Metal Cloud Services go to [github.com/oracle/terraform-provider-baremetal](https://github.com/oracle/terraform-provider-baremetal)

Requirements
------------

-	[Terraform](https://www.terraform.io/downloads.html) 0.7.x or above
-	[Oracle Compute Cloud](https://cloud.oracle.com/compute) Account
-	[Go](https://golang.org/doc/install) 1.7 or above (to build the provider plugin)

OPC Provider Plugin
-------------------

A provider in Terraform is responsible for the lifecycle of a resource: create, read, update, delete. Terraform providers are provided via plugins. Plugins are executed as a separate process and communicate with the main Terraform binary over an RPC interface.

Building
--------

Create a directory where the provider will be built, and set the Go language `GOPATH`

```sh
$ export GOPATH=/home/opc/terraform-provider
$ cd $GOPATH
```

Fetch the source and build the provider.

```sh
$ go get -d github.com/oracle/terraform-provider-compute/provider
$ (cd src/github.com/oracle/terraform-provider-compute/ && git fetch && git checkout ipnetworks-dev)
$ go build -o terraform-provider-opc github.com/oracle/terraform-provider-compute/provider
```

Usage
-----

Add the generated `terraform-provider-opc` executable to your terraform configuration file. The configuration where plugins are defined is `~/.terraformrc` for Unix-like systems and `%APPDATA%/terraform.rc` for Windows, e.g.

```
providers {
    opc = "/home/opc/terraform-provider/terraform-provider-opc"
}
```

To authenticate with the Oracle Compute Cloud the provider will prompt for the required environment credentials. These credentails can be set in the following environment variables:

-	`OPC_ENDPOINT` - Endpoint provided by Oracle Public Cloud (e.g. https://api-z13.compute.em2.oraclecloud.com/\)
-	`OPC_USERNAME` - Username for Oracle Public Cloud
-	`OPC_PASSWORD` - Password for Oracle Public Cloud
-	`OPC_IDENTITY_DOMAIN` - Identity domain for Oracle Public Cloud

or directly in the terraform configuration:

```
provider "opc" {
  user = "xxxx@xxx"
  password = "xxxx"
  identityDomain = "xxxx"
  endpoint = "https://api-z13.compute.em2.oraclecloud.com/"
}
```

### Example Terraform configuration

An example [`test.tf`](test/test.tf) is provided that demonstatates the basic usage of the Oracle Compute Cloud Terraform Provider.

```sh
$ cd $GOPATH/src/github.com/oracle/terraform-provider-compute/test
$ terraform plan
$ terraform apply
$ terraform destroy
```

Additional examples are in the [examples](./examples) directory.

Running the Integration Tests
-----------------------------

An Oracle Compute Cloud Account is required to run the integration tests. The `OCP_*` variables must have been exported

```sh
$ cd $GOPATH/src/github.com/oracle/terraform-provider-compute/sdk/compute
$ go test
```

Common build issues
-------------------

The following build issue can occur if you have an older version of the terraform executable installed.

```
Error configuring: 1 error(s) occurred:

* Incompatible API version with plugin. Plugin version: 4, Ours: 2
```

To build the provider plugin against a specific terraform version, checkout the version in the `$GOPATH/src/github.com/hashicorp/terraform` source directory and rebuild. Be sure the align the checkout tag with the version of terraform you have installed, e.g for `Terraform v0.8.8` you will need to `git checkout v0.8.8`

```sh
$ terraform --version
Terraform v0.8.8

$ ( cd $GOPATH/src/github.com/hashicorp/terraform && git fetch && git checkout v0.8.8 )
$ go build -o $GOPATH/terraform-provider-opc github.com/oracle/terraform-provider-compute/provider
```

To revert back to building againt the latest source change the git checkout statement to `git checkout master`
