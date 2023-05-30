#!/bin/bash

import_sql() {
  local db_host_ip=$1
  local db_password=$2

  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/ldm.sql.zip -O /tmp/ldm.sql.zip
  unzip /tmp/ldm.sql.zip -d /tmp
  echo -e '#!/bin/bash\nmysql -h '$db_host_ip' -uroot -p'$db_password' < /tmp/ldm.sql' > /tmp/init-db.sh
  echo -e 'FROM mysql\nCOPY ldm.sql /tmp/\nCOPY init-db.sh /usr/local/bin/\nRUN chmod u+x /usr/local/bin/init-db.sh\nENTRYPOINT ["init-db.sh"]' > /tmp/Dockerfile

  docker build -f /tmp/Dockerfile -t init-db /tmp
  docker run --net=host --user=root -d init-db
}

save_kubeconfig() {
  rm -rf /root/.kube/
  mkdir -p /root/.kube/
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/kubeconfig.json -O /root/.kube/config
  export KUBECONFIG=/root/.kube/config

  while true
  do
    kubectl version
    if [ $? -eq 0 ]; then
      break
    fi
    sleep 2
  done
  kubectl config use-context internal
}

do_helm_install() {
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/helm_install.sh -O /root/helm_install.sh
  chmod u+x /root/helm_install.sh
  bash -x /root/helm_install.sh
}

import_sql "$1" "$2"
save_kubeconfig
do_helm_install
