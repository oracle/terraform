// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved
// Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# Outputing required info for users
output "Bridge Instance Public IP" {
  value = "${data.oci_core_instance.bridge_instance.public_ip}"
}

output "PrivateInstance1 Private IP" {
  value = "${oci_core_instance.PrivateInstance.private_ip}"
}

output "PrivateInstance2 Private IP" {
  value = "${oci_core_instance.PrivateInstance2.private_ip}"
}

output "SSH login to the Bridge Instance" {
  value = "ssh -A opc@${data.oci_core_instance.bridge_instance.public_ip}"
}

output "SSH login to the Private Instance-1 after logging into Bridge Instance as shown above" {
  value = "ssh -A opc@${oci_core_instance.PrivateInstance.private_ip}"
}

output "SSH login to the Private Instance-2 after logging into Bridge Instance as shown above" {
  value = "ssh -A opc@${oci_core_instance.PrivateInstance2.private_ip}"
}

output "Ping from PrivateInstance-1 to PrivateInstance-2" {
  value = "ping ${oci_core_instance.PrivateInstance2.private_ip} "
}
