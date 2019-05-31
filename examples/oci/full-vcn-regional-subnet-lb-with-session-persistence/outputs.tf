// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
output "lb_public_ip" {
  value = ["${oci_load_balancer.web-lb1.ip_addresses}"]
}
