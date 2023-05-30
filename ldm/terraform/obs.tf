// cce创建完毕后，上传kubeconfig文件
resource "huaweicloud_obs_bucket_object" "kube_config" {
  depends_on = [huaweicloud_cce_cluster.cce_ldm]

  bucket = "ldm-res"
  key    = "kubeconfig.json"
  source = "./resources/kubeconfig.json"
}

resource "huaweicloud_obs_bucket_object" "outputs" {
  depends_on = [null_resource.outputs]

  bucket = "ldm-res"
  key    = "outputs.yaml"
  source = "./resources/outputs.yaml"
}
