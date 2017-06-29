Terraform Provider for Oracle Compute Cloud
===========================================

**THE PROVIDER PLUGIN IMPLEMENTATION IN THIS REPOSITORY IS DEPRECATED**

**For Terraform release 0.9.4 and onwards the Oracle Compute Cloud resouce provisioning is supported by the built-in Oracle Public Cloud `opc` provider included in the main Terraform distribution**. See the [Terraform Oracle Public Cloud Provider](https://www.terraform.io/docs/providers/opc/index.html) documentation for more details.

**All future development and ongoing support for the built-in `opc` provider is at https://github.com/terraform-providers/terraform-provider-opc*** 

If you are still using Terraform 0.7.x to 0.9.3 the provider **plugin** in this repository is required to provision Oracle Compute Cloud resources. See the details below to build and install the provider plugin.  See the [migration guide](MIGRATION.md) to update existing configurations and deployments to the build-in provider for Terraform 0.9.4+

For the Terraform Provider for Oracle Bare Metal Cloud Services go to [github.com/oracle/terraform-provider-baremetal](https://github.com/oracle/terraform-provider-baremetal)

Requirements
------------

-	[Terraform](https://www.terraform.io/downloads.html) 0.7.x to 0.9.3
-	[Oracle Compute Cloud](https://cloud.oracle.com/compute) Account
-	[Go](https://golang.org/doc/install) 1.8 or above (to build the provider plugin)

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
$ go build -o terraform-provider-opc github.com/oracle/terraform-provider-compute/provider
```

Usage
-----

Add the generated `terraform-provider-opc` executable to your `.terraformrc` configuration (`%APPDATA%/terraform.rc` on Windows), e.g.

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
- `OPC_INSECURE` - Allow self signed certificates

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

Additional examples are in the [examples](./examples/plugin) directory.

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

* Incompatible API version with plugin. Plugin version: 3, Ours: 2
```

To build the provider plugin against a specific terraform version, checkout the version in the `$GOPATH/src/github.com/hashicorp/terraform` source directory and rebuild. Be sure the align the checkout tag with the version of terraform you have installed, e.g for `Terraform v0.8.5` you will need to `git checkout v0.8.5`

```sh
$ terraform --version
Terraform v0.8.5

$ ( cd $GOPATH/src/github.com/hashicorp/terraform && git checkout v0.8.5 )
$ go build -o terraform-provider-opc github.com/oracle/terraform-provider-compute/provider
```

To revert back to building againt the latest source change the git checkout statement to `git checkout master`
