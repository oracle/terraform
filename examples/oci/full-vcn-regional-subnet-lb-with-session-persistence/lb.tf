// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
/* Load Balancer */
resource "oci_load_balancer" "web-lb1" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"

  subnet_ids = [
    "${oci_core_subnet.public_subnet1.id}",
  ]

  #"${oci_core_subnet.public_subnet2.id}"

  display_name = "web-lb1"
}

resource "oci_load_balancer_backend_set" "web-lb-bes1" {
  name             = "web-lb-bes1"
  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

/*  resource "oci_load_balancer_certificate" "lb-cert1" {
  load_balancer_id   = "${oci_load_balancer.web-lb1.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
  */
resource "oci_load_balancer_hostname" "test_hostname1" {
  #Required
  hostname         = "${var.hostname}"
  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  name             = "hostname1"
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${oci_load_balancer.web-lb1.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb-bes1.name}"
  hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_backend" "web-lb-be1" {
  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  backendset_name  = "${oci_load_balancer_backend_set.web-lb-bes1.name}"
  ip_address       = "${oci_core_instance.vcn1-instance1.private_ip}"
  port             = 8080
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "web-lb-be2" {
  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  backendset_name  = "${oci_load_balancer_backend_set.web-lb-bes1.name}"
  ip_address       = "${oci_core_instance.vcn1-instance2.private_ip}"
  port             = 8080
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_path_route_set" "test_path_route_set" {
  #Required
  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  name             = "pr-set1"

  path_routes {
    #Required
    backend_set_name = "${oci_load_balancer_backend_set.web-lb-bes1.name}"
    path             = "/sample"

    path_match_type {
      #Required
      match_type = "PREFIX_MATCH"
    }
  }
}

resource "oci_load_balancer_rule_set" "test_rule_set" {
  items {
    action = "ADD_HTTP_REQUEST_HEADER"
    header = "WL-Proxy-SSL"
    value  = "true"
  }

  load_balancer_id = "${oci_load_balancer.web-lb1.id}"
  name             = "example_rule_set_name"
}
