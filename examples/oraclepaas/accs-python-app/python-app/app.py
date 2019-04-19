#!/usr/bin/python
# Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

import os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT_NUMBER = int(os.environ.get("PORT", 8084))

# HTTPRequestHandler class


class testHTTPServer_RequestHandler(BaseHTTPRequestHandler):

    # GET
    def do_HEAD(self):
        # Send response status code
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        return

    # GET

    def do_GET(self):
        # Send response status code
        self.send_response(200)

        # Send headers
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Send message back to client
        message = "Hello world!"
        # Write content as utf-8 data
        self.wfile.write(bytes(message, "utf8"))
        return


def run():
    print("starting server...")

    # Server settings
    # Choose port 8080, for port 80, which is normally used for a http server, you need root access
    server_address = ("0.0.0.0", PORT_NUMBER)
    httpd = HTTPServer(server_address, testHTTPServer_RequestHandler)
    print("running server...")
    httpd.serve_forever()


run()
