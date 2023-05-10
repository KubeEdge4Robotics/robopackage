#!/bin/bash

import_sql() {
  local db_host_ip=$1
  local db_password=$2

  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/ldm.sql -O /tmp/ldm.sql
  echo -e '#!/bin/bash\nmysql -h '$db_host_ip' -uroot -p'$db_password' < /tmp/ldm.sql' > /tmp/init-db.sh
  echo -e 'FROM mysql\nCOPY ldm.sql /tmp/\nCOPY init-db.sh /usr/local/bin/\nRUN chmod u+x /usr/local/bin/init-db.sh\nENTRYPOINT ["init-db.sh"]' > /tmp/Dockerfile

  docker build -f /tmp/Dockerfile -t init-db /tmp
  docker run --net=host --user=root -d init-db
}

save_kubeconfig() {
  rm -rf /root/.kube/
  mkdir -p /root/.kube/
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/kubeconfig.json -O /root/.kube/config
  kubectl config use-context internal
}

taint_cce_node() {
  # IES节点可以调度
  kubectl taint nodes distribution.io/category- --all
  # Center节点不可调度
  node_ip=$(kubectl get nodes | grep 192.168.0 | awk '{print $1}') # 192.168.0.0/24是subnet_center子网，要保持一致，否则找不到center节点
  kubectl taint nodes $node_ip distribution.io/category=center:NoSchedule
}

do_helm_install() {
  wget https://ldm-res.obs.cn-south-1.myhuaweicloud.com/helm_install.sh -O /root/helm_install.sh
  chmod u+x /root/helm_install.sh
  bash -x /root/helm_install.sh
}

import_sql "$1" "$2"
save_kubeconfig
taint_cce_node
do_helm_install
