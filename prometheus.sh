#!/bin/bash
systemctl stop firewalld;
systemctl disable firewalld;
setenforce 0;
useradd -d /dev/null -s /usr/sbin/nologin prometheus;
mkdir /tmp/prometheus;
mkdir /etc/prometheus;
mkdir /var/lib/prometheus;
chown -R prometheus:prometheus /tmp/prometheus;
chown -R prometheus:prometheus /etc/prometheus;
chown -R prometheus:prometheus /var/lib/prometheus;
cp prometheus/prometheus /usr/local/bin/;
cp prometheus/promtool /usr/local/bin/;
cp prometheus/prometheus.j2 /etc/systemd/system/prometheus.service;
cp prometheus/prometheus.yml /etc/prometheus/prometheus.yml;
systemctl enable prometheus --now;
cp prometheus/grafana.repo /etc/yum.repos.d/grafana.repo;
yum -y install grafana;
systemctl enable grafana-server --now;
sleep 1m;
grafana-cli admin reset-admin-password hunter1981;
