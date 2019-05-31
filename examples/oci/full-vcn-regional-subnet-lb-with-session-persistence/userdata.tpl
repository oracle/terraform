# Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start
# echo '########## yum update all ###############'
# yum update -y
echo '########## basic webserver ##############'
yum install -y tomcat
yum install -y tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc
echo "<br>Host:" >> /usr/share/tomcat/webapps/sample/hello.jsp
sed -i -e "s/8080/${port}/g" /usr/share/tomcat/conf/server.xml
hostname >> /usr/share/tomcat/webapps/sample/hello.jsp
firewall-offline-cmd --add-port=${port}/tcp
systemctl enable  firewalld
systemctl restart  firewalld
systemctl start tomcat
systemctl enable tomcat

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'

