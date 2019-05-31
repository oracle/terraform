// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

data "template_file" "init" {
  template = "${file("userdata.tpl")}"

  vars = {
    port = "8080"
  }
}

data "template_file" "privkey" {
  template = "${file("certs/privkey.pem")}"
}

data "template_file" "cert" {
  template = "${file("certs/cert.pem")}"
}

data "template_file" "cacert" {
  template = "${file("certs/cacert.pem")}"
}

data "oci_core_services" "test_services" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
}
