#!/bin/bash

access_key=$1
secret_key=$2
region=$3

# for obs
export LC_ALL=en_US.en
obs_date=$(date -u +"%a, %d %b %Y %H:%M:%S GMT")
obs_bucket="ldm-res"

generate_signature() {
  local resource="/$obs_bucket/$1"
  local string_to_sign="GET\n\n\n$obs_date\n$resource"
  local signature=$(echo -en $string_to_sign | openssl sha1 -hmac $secret_key -binary | base64)
  authorization_header="OBS $access_key:$signature"
}

download_obs_file() {
  local filename=$1
  local target=$2
  generate_signature $filename
  echo $authorization_header
  curl -H "Date: $obs_date" -H "Authorization: $authorization_header" https://ldm-res.obs.cn-south-1.myhuaweicloud.com/$filename -o $target
}

import_sql() {
  download_obs_file outputs.yaml /tmp/outputs.yaml
  rds_host_ip=$(cat /tmp/outputs.yaml | grep rds_host_ip | awk '{print $2}')
  rds_password=$(cat /tmp/outputs.yaml | grep rds_password | awk '{print $2}')

  download_obs_file ldm.sql.zip /tmp/ldm.sql.zip
  unzip /tmp/ldm.sql.zip -d /tmp
  echo -e '#!/bin/bash\nmysql -h '$rds_host_ip' -uroot -p'$rds_password' < /tmp/ldm.sql' > /tmp/init-db.sh
  echo -e 'FROM mysql\nCOPY ldm.sql /tmp/\nCOPY init-db.sh /usr/local/bin/\nRUN chmod u+x /usr/local/bin/init-db.sh\nENTRYPOINT ["init-db.sh"]' > /tmp/Dockerfile

  docker build -f /tmp/Dockerfile -t init-db /tmp
  docker run --net=host --user=root -d init-db
}

save_kubeconfig() {
  rm -rf /root/.kube/
  mkdir -p /root/.kube/
  download_obs_file kubeconfig.json /root/.kube/config
  export KUBECONFIG=/root/.kube/config
  kubectl config use-context internal
}

do_helm_install() {
  download_obs_file "helm_install.sh" "/root/helm_install.sh"
  chmod u+x /root/helm_install.sh
  bash -x /root/helm_install.sh $access_key $secret_key $region
}

import_sql
save_kubeconfig
do_helm_install
