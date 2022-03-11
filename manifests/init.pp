class minio (
  String $install_dir           = $minio::params::install_dir,
  String $config_dir            = $minio::params::config_dir,
  String $storage_dir           = $minio::params::storage_dir,
  String $user                  = $minio::params::user,
  String $group                 = $minio::params::group,
  String $manage_user           = $minio::params::manage_user,
) inherits minio::params {

  contain minio::install
}