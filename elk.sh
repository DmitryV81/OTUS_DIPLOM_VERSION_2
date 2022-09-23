#!/bin/bash
systemctl stop firewalld;
systemctl disable firewalld;
sestatus 0;
yum -y install elk/elasticsearch_7.17.3_x86_64-224190-9bcb26.rpm;
cp elk/jvm.options /etc/elasticsearch/jvm.options.d/jvm.options;
systemctl enable elasticsearch --now;
yum -y install elk/kibana_7.17.3_x86_64-224190-b13e53.rpm;
cp elk/kibana.yml /etc/kibana/kibana.yml;
systemctl enable kibana --now;
yum -y install elk/logstash_7.17.3_x86_64-224190-3a605f.rpm;
cp elk/logstash.yml /etc/logstash/logstash.yml;
cp elk/logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf;
systemctl enable logstash --now;
