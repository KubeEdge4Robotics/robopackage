#!/bin/bash

access_key=$1
secret_key=$2
region=$3
obs_res_bucket=$4

# for obs
export LC_ALL=en_US.en
obs_date=$(date -u +"%a, %d %b %Y %H:%M:%S GMT")

generate_signature() {
  local resource="/$obs_res_bucket/$1"
  local string_to_sign="GET\n\n\n$obs_date\n$resource"
  local signature=$(echo -en $string_to_sign | openssl sha1 -hmac $secret_key -binary | base64)
  authorization_header="OBS $access_key:$signature"
}

download_obs_file() {
  local filename=$1
  local target=$2
  generate_signature $filename
  echo $authorization_header
  curl -H "Date: $obs_date" -H "Authorization: $authorization_header" https://$obs_res_bucket.obs.cn-south-1.myhuaweicloud.com/$filename -o $target
}

# 下载并安装helm工具
install_helm_cli() {
  download_obs_file helm-v3.11.3-linux-amd64.tar.gz helm-v3.11.3-linux-amd64.tar.gz
  tar -zxvf helm-v3.11.3-linux-amd64.tar.gz
  cp linux-amd64/helm /usr/local/bin/
}

install_helm_chart() {
  # 下载ldm charts包并解压
  download_obs_file ldm-helm-chart.tar.gz ldm-helm-chart.tar.gz
  tar -zxvf ldm-helm-chart.tar.gz
  # 解析outputs.yaml
  rds_host_ip=$(cat /tmp/outputs.yaml | grep rds_host_ip | awk '{print $2}')
  rds_username=$(cat /tmp/outputs.yaml | grep rds_username | awk '{print $2}')
  rds_password=$(cat /tmp/outputs.yaml | grep rds_password | awk '{print $2}')
  rds_db_name=$(cat /tmp/outputs.yaml | grep rds_db_name | awk '{print $2}')
  dcs_host_ip=$(cat /tmp/outputs.yaml | grep dcs_host_ip | awk '{print $2}')
  dcs_password=$(cat /tmp/outputs.yaml | grep dcs_password | awk '{print $2}')

  cd helmchart
  install_ldmbase_chart
  install_ldmcore_chart
  install_ldmalg_chart
  sleep 30
  install_ldmrcs_chart
}

install_ldmbase_chart() {
  helm install ldm-base \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.host=$dcs_host_ip \
--set config.redis.password=$dcs_password \
-f values-ldmbase.yaml ldmbase
}

install_ldmcore_chart() {
  helm install ldm-core \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.host=$dcs_host_ip \
--set config.redis.password=$dcs_password \
-f values-ldmcore.yaml ldmcore
}

install_ldmalg_chart() {
  helm install ldm-alg \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
--set config.redis.host=$dcs_host_ip \
--set config.redis.password=$dcs_password \
-f values-ldmalg.yaml ldmalg
}

install_ldmrcs_chart() {
  helm install ldm-rcs \
--set config.mysql.host=$rds_host_ip \
--set config.mysql.username=$rds_username \
--set config.mysql.password=$rds_password \
--set config.mysql.db=$rds_db_name \
-f values-ldmrcs.yaml ldmrcs
}

install_helm_cli
install_helm_chart
