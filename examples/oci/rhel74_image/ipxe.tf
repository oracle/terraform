# DO NOT ALTER THIS FILE

resource "oci_core_instance" "ipxe_node" {
  availability_domain = "${data.oci_identity_availability_domains.ad.availability_domains.0.name}"
  compartment_id      = "${data.oci_identity_compartments.compartment.compartments.0.id}"
  display_name        = "${var.ipxe_instance["name"]}"
  image               = "${var.ipxe_image_ocid[var.region]}"
  shape               = "${var.ipxe_instance["shape"]}"
  subnet_id           = "${data.oci_core_subnets.subnet.subnets.0.id}"
  hostname_label      = "${var.ipxe_instance["hostname"]}"

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${data.template_cloudinit_config.cloudinit_config.rendered}"
  }
}

resource "null_resource" "delete_ipxe" {
  triggers {
    ipxe_node_id = "${oci_core_instance.ipxe_node.id}"
  }
  provisioner "local-exec" {
    command = "rm -rf ./ipxe.sh"
  }
}

resource "null_resource" "delete_ipxe_destroy" {
  provisioner "local-exec" {
    when = "destroy"
    command = "rm -rf ./ipxe.sh"
  }
}
