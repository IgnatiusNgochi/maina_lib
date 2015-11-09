#!/bin/bash
cd $(dirname $0)


#export PATH=/opt/jdk1.7.0_79/bin
#export CLASSPATH=/opt/tomcat/lib/servlet-api.jar
#export CLASSPATH=$CLASSPATH:/opt/tomcat/webapps/hhs/WEB-INF/lib/json_simple-1.1.1.jar
#export CLASSPATH=$CLASSPATH:/opt/tomcat/webapps/hhs/WEB-INF/classes/



TOMCAT_PATH=/Users/henriquedn/Lab/Apache/tomcat
WEBAPP_NAME=denoproject

export PATH=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/bin/
export CLASSPATH=$TOMCAT_PATH/lib/servlet-api.jar
export CLASSPATH=$CLASSPATH:$TOMCAT_PATH/webapps/$WEBAPP_NAME/WEB-INF/lib/json-simple-1.1.1.jar

echo 'Compiling .........'
javac org/hhs/db/*.java
#javac org/hhs/*.java

echo 'Done Compiling'
