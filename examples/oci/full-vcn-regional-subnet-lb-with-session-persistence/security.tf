/* Security List */
resource "oci_core_security_list" "public-securitylist" {
  display_name   = "public"
  compartment_id = "${oci_core_vcn.vcn1.compartment_id}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 80
        "max" = 80
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 88
        "max" = 88
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 99
        "max" = 99
      }
    },
    {
      protocol = "6"
      source   = "${var.admin_subnet}"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}

resource "oci_core_security_list" "private-securitylist" {
  display_name   = "private"
  compartment_id = "${oci_core_vcn.vcn1.compartment_id}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
    {
      protocol = "6"
      source   = "${oci_core_subnet.public_subnet1.cidr_block}"

      tcp_options {
        "min" = 80
        "max" = 80
      }
    },
    {
      protocol = "6"
      source   = "${oci_core_subnet.public_subnet1.cidr_block}"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      source   = "${oci_core_subnet.public_subnet1.cidr_block}"

      tcp_options {
        "min" = 8080
        "max" = 8080
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 8009
        "max" = 8009
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 8008
        "max" = 8008
      }
    },
    {
      protocol = "6"
      source   = "${var.admin_subnet}"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}

## Lockdown default security list
resource "oci_core_default_security_list" "default-securitylist" {
  manage_default_resource_id = "${oci_core_vcn.vcn1.default_security_list_id}"
  display_name               = "default"

  egress_security_rules = [{
    protocol    = "all"
    destination = "${var.admin_subnet}"
  }]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "${var.admin_subnet}"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}

resource "oci_core_security_list" "private-securitylist2" {
  display_name   = "private"
  compartment_id = "${oci_core_vcn.vcn2.compartment_id}"
  vcn_id         = "${oci_core_vcn.vcn2.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "all"
      source   = "${oci_core_vcn.vcn1.cidr_block}"
    },
  ]
}
