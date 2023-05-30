// TODO 配置obs策略，限制当前用户可下载，外网不可下载
resource "huaweicloud_obs_bucket" "ldm_res" {
  bucket = "ldm-res"
  acl    = "private"
}

// TODO 数据库结构+数据可以从事先创建的OBS桶里下载
resource "huaweicloud_obs_bucket_object" "ldm_sql" {
  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "ldm.sql.zip"
  source = "./resources/ldm.sql.zip"
  acl    = "public-read"
}

resource "huaweicloud_obs_bucket_object" "post_install" {
  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "post_install.sh"
  source = "./resources/post_install.sh"
  acl    = "public-read"
}

// cce创建完毕后，上传kubeconfig文件
resource "huaweicloud_obs_bucket_object" "kube_config" {
  depends_on = [huaweicloud_cce_cluster.cce_ldm]

  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "kubeconfig.json"
  source = "./resources/kubeconfig.json"
  acl    = "public-read" // kubeconfig未暴露公网ip，安全性可控
}

///////HELM///////
resource "null_resource" "prepare_work" {
  provisioner "local-exec" {
    // 1. 下载helm工具包
    // 2. 打包ldm helm charts
    command = <<-EOT
if [ ! -f "./resources/helm-v3.11.3-linux-amd64.tar.gz" ]; then
  wget https://get.helm.sh/helm-v3.11.3-linux-amd64.tar.gz -O ./resources/helm-v3.11.3-linux-amd64.tar.gz
fi

tar -zcvf ./resources/ldm-helm-chart.tar.gz ../helmchart
EOT
  }
}

resource "huaweicloud_obs_bucket_object" "helm_cli" {
  depends_on = [null_resource.prepare_work]

  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "helm-v3.11.3-linux-amd64.tar.gz"
  source = "./resources/helm-v3.11.3-linux-amd64.tar.gz"
  acl    = "public-read"
}

resource "huaweicloud_obs_bucket_object" "ldm_helm_chart" {
  depends_on = [null_resource.prepare_work]

  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "ldm-helm-chart.tar.gz"
  source = "./resources/ldm-helm-chart.tar.gz"
  acl    = "public-read"
}

resource "huaweicloud_obs_bucket_object" "helm_install" {
  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "helm_install.sh"
  source = "./resources/helm_install.sh"
  acl    = "public-read"
}

resource "huaweicloud_obs_bucket_object" "outputs" {
  depends_on = [null_resource.outputs]

  bucket = huaweicloud_obs_bucket.ldm_res.bucket
  key    = "outputs.yaml"
  source = "./resources/outputs.yaml" // rds和cce节点未暴露公网ip，安全性可控
  acl    = "public-read"
}
