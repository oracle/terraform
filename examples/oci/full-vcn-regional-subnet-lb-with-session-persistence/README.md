

    #     ___  ____     _    ____ _     _____
    #    / _ \|  _ \   / \  / ___| |   | ____|
    #   | | | | |_) | / _ \| |   | |   |  _|
    #   | |_| |  _ < / ___ | |___| |___| |___
    #    \___/|_| \_/_/   \_\____|_____|_____|
***
### Full VCN with Service Gateway, NAT Gateway and One Tier Web App with 1 Load Balancer & 2 static instances running on OCI

### Using this example
* Update env-vars with the required information. Most examples use the same set of environment variables so you only need to do this once.

Follow the directions from this page to create an ssl certificate:
https://docs.cloud.oracle.com/iaas/Content/Balance/Tasks/managingcertificates.htm

Under the certs folder you will update the following files with the following certificates:
cacert.pem - Certificate of the issuing certificate authority
cert.pem - The SSL certificate issued for this workloa
privkey.pem - Private key of the certificate
* Execute env-vars script


* You can locate the tenancy and user OCID, as well as learn how to create API signing keys by using this reference: https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm

### Authentication details
* export TF_VAR_tenancy_ocid="<tenancy OCID goes here>"

* export TF_VAR_user_ocid="<user OCID goes here>"

* export TF_VAR_fingerprint="<private key fingerprint goes here>"

* export TF_VAR_private_key_path="<full local path of API private key in .PEM format goes here>"

export TF_VAR_private_key_password="$(cat <full local path for file containing passcode of API private key goes here>)"

### Compartment
* export TF_VAR_compartment_ocid="<compartment OCID goes here>"

### Public/private keys used on the instance
*export TF_VAR_ssh_public_key=$(cat <full local path of instance SSH public key in .PEM format goes here>)


  * `$ . env-vars`
* Update `terraform.tfvars` with your instance options.

* These are the default values

instance_shape = "VM.Standard2.1"
availability_domain = "3"
region = "us-ashburn-1"
admin_subnet = "10.0.0.0/8"
assign_public_ip_instance = "false"
hostname = "hostname pointing to your load balancer ip"
* run the command:  terraform init
* * This command will download the oci provider and the template_file data source used to import the user-data script for the oci instances

* run the command:  terraform plan

* run the command:  terraform apply
* * You will be prompted to accept the changes type yes and press enter

* To remove all changes run the command: terraform destroy
* * You will be prompted to accept the changes type yes and press enter

### Files in the configuration

#### `env-vars`
Is used to export the environmental variables used in the configuration. These are usually authentication related, be sure to exclude this file from your version control system. It's typical to keep this file outside of the configuration.

Before you plan, apply, or destroy the configuration source the file -  
`$ . env-vars`

#### `terraform.tfvars`
Defines stack specific variables to define workload specific definitions

#### `compute.tf`
Defines the compute resources

#### `security.tf`
Defines the security lists for the subnets

#### `lb.tf`
Defines the loadbalancer resources

#### `networking.tf`
Defines the virtual cloud network resources used in the configuration

#### `variables.tf`
Defines the variables used in the configuration

#### `datasources.tf`
Defines the datasources used in the configuration

#### `provider.tf`
Specifies and passes authentication details to the OCI TF provider

#### `./userdata.tpl`
The script gets injected into an instance on launch.
The script configures a test webserver for displaying the backend server private ip.

#### `./outputs.tf`
Returns vaules necessary for use of the workload
lb_public_ip is the Public IP address of the load balancer and can accessed as http://<lb_public_ip>:80/sample/hello.jsp
