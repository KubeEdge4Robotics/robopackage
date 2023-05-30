// CCE集群创建完毕后，上传kubeconfig文件
resource "huaweicloud_obs_bucket_object" "kube_config" {
  depends_on = [huaweicloud_cce_cluster.cce_ldm]

  bucket = var.obs_res_bucket
  key    = "kubeconfig.json"
  source = "kubeconfig.json"
}

resource "huaweicloud_obs_bucket_object" "outputs" {
  depends_on = [huaweicloud_cce_cluster.cce_ldm]

  bucket = var.obs_res_bucket
  key    = "outputs.yaml"
  source = "outputs.yaml"
}
