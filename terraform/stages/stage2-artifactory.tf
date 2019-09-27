module "dev_serviceaccount_artifactory" {
  source = "github.com/ibm-garage-cloud/garage-terraform-modules.git//cluster/serviceaccount?ref=v1.0.0"

  cluster_type             = "${var.cluster_type}"
  namespace                = "${module.dev_cluster_namespaces.tools_namespace_name}"
  cluster_config_file_path = "${module.dev_cluster.config_file_path}"
  service_account_name     = "artifactory-artifactory"
  sscs                     = ["anyuid", "privileged"]
}

module "dev_tools_artifactory_release" {
  source = "github.com/ibm-garage-cloud/garage-terraform-modules.git//tools/artifactory_release?ref=v1.0.0"

  cluster_type             = "${var.cluster_type}"
  service_account          = "${module.dev_serviceaccount_artifactory.name}"
  cluster_ingress_hostname = "${module.dev_cluster.ingress_hostname}"
  cluster_config_file      = "${module.dev_cluster.config_file_path}"
  releases_namespace       = "${module.dev_cluster_namespaces.tools_namespace_name}"
}