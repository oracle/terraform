// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
/* Instances */

resource "oci_core_instance" "vcn1-instance1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain -1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "vcn1-instance1"
  shape               = "${var.instance_shape}"
  hostname_label      = "vcn1-instance1"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.private_subnet1.id}"
    assign_public_ip = "${var.assign_public_ip_instance}"
  }

  metadata {
    user_data           = "${base64encode(data.template_file.init.rendered)}"
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"
  }
}

resource "oci_core_instance" "vcn1-instance2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain -1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "vcn1-instance2"
  shape               = "${var.instance_shape}"
  hostname_label      = "vcn1-instance2"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.private_subnet1.id}"
    assign_public_ip = "${var.assign_public_ip_instance}"
  }

  metadata {
    user_data           = "${base64encode(data.template_file.init.rendered)}"
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"
  }
}

resource "oci_core_instance" "vcn2-instance1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain -1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "vcn2-instance1"
  shape               = "${var.instance_shape}"
  hostname_label      = "vcn2-instance1"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.private_subnet2.id}"
    assign_public_ip = "${var.assign_public_ip_instance}"
  }

  metadata {
    user_data           = "${base64encode(data.template_file.init.rendered)}"
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"
  }
}

resource "oci_core_instance_configuration" "vcn1-instance_configuration" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn1-instance"

  instance_details {
    instance_type = "compute"

    launch_details {
      source_details {
        source_type = "image"
        image_id    = "${var.instance_image_ocid[var.region]}"
      }

      create_vnic_details {
        skip_source_dest_check = true
      }

      compartment_id = "${var.compartment_ocid}"
      display_name   = "vcn1-instance"
      shape          = "${var.instance_shape}"

      metadata {
        user_data           = "${base64encode(data.template_file.init.rendered)}"
        ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
      }

      timeouts {
        create = "10m"
      }
    }
  }
}

resource "oci_core_instance_pool" "vcn1-instance_pool" {
  display_name              = "vcn1_loadbalanced_pool"
  compartment_id            = "${var.compartment_ocid}"
  instance_configuration_id = "${oci_core_instance_configuration.vcn1-instance_configuration.id}"

  placement_configurations {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain -1],"name")}"
    primary_subnet_id   = "${oci_core_subnet.private_subnet1.id}"
  }

  size = "${var.instance_count}"
}
