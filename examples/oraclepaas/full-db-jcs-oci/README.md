Example Java Cloud Service instance on OCI using OCI Native DB
==============================================================

This example creates an Oracle Java Cloud Service instance using a Oracle Database instance deployed on Oracle Cloud Infrastructure.

To deploy the Oracle Pass Service Manager (PSM) managed services on OCI a number of prerequisites must be configured

The `identity.tf` creates a deployment specific object storage user account and configure the access policies.

- Configure the Policies to enable PSM to access and provision services in the target Compartment
- Creates a new API only user account and authentication token for managing the object storage backup bucket.
- Configures the appropriate policies to enabled the user to access the backup storage bucket.

The `main.tf` creates the resources to:

- Deploy the `oci_database_db_system` Oracle Database VM instance on OCI
- Create the`oci_objectstorage_bucket` OCI Object Storage bucket for the Java Cloud Service backups
- Deploy the `oraclepaas_java_service_instance` JCS service instance on OCI using the OCI DB and OCI Object Storage backup bucket

## Usage

Create a local `terraform.tfvars` with your account specific credentials and settings

```
## Oracle Cloud Credentials
identity_service_id = "idcs-00000000000000000000000000000000"

user = "user@example.com"
password = "Pa55_Word"
user_ocid = "ocid1.user.oc1..000000000000000000000000000000000000000000000000000000000000"
fingerprint = "aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99"
private_key_path = "/Users/user/.oci/oci_api_key.pem"

## OCI
tenancy = "example"
tenancy_ocid = "ocid1.tenancy.oc1..000000000000000000000000000000000000000000000000000000000000"

# OCI Home region (for identity configuration)
home_region = "us-ashburn-1"

# OCI Deployment region (for DB/JCS instance deployment)
region = "us-phoenix-1"
compartment_ocid = "ocid1.compartment.oc1..000000000000000000000000000000000000000000000000000000000000"
subnet_ocid = "ocid1.subnet.oc1.phx.000000000000000000000000000000000000000000000000000000000000"
```

To deploy, run terraform:

```
$ terraform init
$ terraform apply
```

To remove all the deployed resources:

```
$ terraform destroy
```
