// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
var http = require('http');
// Read Environment Parameters
var port = Number(process.env.PORT || 8080);
var greeting = process.env.GREETING || 'Hello World!';
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end(greeting + "\n");
});
server.listen(port);
