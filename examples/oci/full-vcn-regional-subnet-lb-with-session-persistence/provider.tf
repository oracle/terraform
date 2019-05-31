// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
provider "oci" {
  version              = ">= 3.2"
  tenancy_ocid         = "${var.tenancy_ocid}"
  user_ocid            = "${var.user_ocid}"
  fingerprint          = "${var.fingerprint}"
  private_key_path     = "${var.private_key_path}"
  private_key_password = "${var.private_key_password}"
  region               = "${var.region}"
}

# Optional: Oracle Cloud Infrastructure provider to use Instance Principal based authentication
#provider "oci" {
#  version          = ">= 3.0.0"
#  auth = "InstancePrincipal"
#  region = "${var.region}"
#}

