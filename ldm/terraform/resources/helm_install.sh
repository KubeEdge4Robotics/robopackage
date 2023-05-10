#!/bin/bash

# 下载并安装helm工具
install_helm_cli() {
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/helm-v3.11.3-linux-amd64.tar.gz
  tar -zxvf helm-v3.11.3-linux-amd64.tar.gz
  cp linux-amd64/helm /usr/local/bin/
}

install_helm_chart() {
  # 下载ldm charts包并解压
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/ldm-helm-chart.tar.gz
  tar -zxvf ldm-helm-chart.tar.gz
  # 下载outputs.yaml并解析值
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/outputs.yaml
  rds_host_ip=$(cat outputs.yaml | grep rds_host_ip | awk '{print $2}')
  rds_username=$(cat outputs.yaml | grep rds_username | awk '{print $2}')
  rds_password=$(cat outputs.yaml | grep rds_password | awk '{print $2}')
  rds_db_name=$(cat outputs.yaml | grep rds_db_name | awk '{print $2}')

  cd helmchart
  install_redis_chart $rds_password # TODO redis密码和rds密码保持相同
  kubectl wait -l statefulset.kubernetes.io/pod-name=redis-master-0 --for=condition=ready pod --timeout=-1s
  install_ldmbase_chart $rds_host_ip $rds_username $rds_password $rds_db_name
  install_ldmcore_chart $rds_host_ip $rds_username $rds_password $rds_db_name
  install_ldmalg_chart $rds_host_ip $rds_username $rds_password $rds_db_name
  sleep 30
  install_ldmrcs_chart $rds_host_ip $rds_username $rds_password $rds_db_name
}

install_redis_chart() {
  local redis_password=$1
  helm install redis \
--set global.redis.password=$redis_password \
-f values-redis.yaml redis
}

install_ldmbase_chart() {
  local rds_host_ip=$1
  local rds_username=$2
  local rds_password=$3
  local rds_db_name=$4
  local redis_password=$rds_password
  helm install ldm-base \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.password=$redis_password \
-f values-ldmbase.yaml ldmbase
}

install_ldmcore_chart() {
  local rds_host_ip=$1
  local rds_username=$2
  local rds_password=$3
  local rds_db_name=$4
  local redis_password=$rds_password
  helm install ldm-core \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.password=$redis_password \
-f values-ldmcore.yaml ldmcore
}

install_ldmalg_chart() {
  local rds_host_ip=$1
  local rds_username=$2
  local rds_password=$3
  local rds_db_name=$4
  local redis_password=$rds_password
  helm install ldm-alg \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.password=$redis_password \
-f values-ldmalg.yaml ldmalg
}

install_ldmrcs_chart() {
  local rds_host_ip=$1
  local rds_username=$2
  local rds_password=$3
  local rds_db_name=$4
  helm install ldm-rcs \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
-f values-ldmrcs.yaml ldmrcs
}

install_helm_cli
install_helm_chart
