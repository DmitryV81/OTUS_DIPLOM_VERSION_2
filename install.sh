#!/bin/bash
MYSQLSLAVE="root@192.168.56.118"
WEBSERVER="root@192.168.56.117";
ELK="root@192.168.56.116";
PROMETHEUS="192.168.56.115"
SOURCE_HOST_FOR_REPLICA="192.168.56.117";
DB="wordpress";
USER="root";
PASS="Hunter1981!";
DIR="/root/backupdb/wordpress";

scp mysqlslave.sh $MYSQLSLAVE:/root/mysqlslave.sh;
scp -r files $MYSQLSLAVE:/root/;
ssh $MYSQLSLAVE 'bash -s' < mysqlslave.sh

scp webserver.sh $WEBSERVER:/root/webserver.sh;
scp -r files $WEBSERVER:/root/;
scp -r backupdb $WEBSERVER:/root/;
scp -r filebeat $WEBSERVER:/root/;
ssh $WEBSERVER 'bash -s' < webserver.sh;

#scp elk.sh $ELK:/root/elk.sh;
#scp -r elk $ELK:/root/;
#ssh $ELK 'bash -s' < elk.sh;

#scp prometheus.sh $PROMETHEUS:/root/prometheus.sh;
#scp -r prometheus $PROMETHEUS:/root/;
#ssh $PROMETHEUS 'bash -s' < prometheus.sh;
