class minio::install (
  Boolean $curl_ensure    = true,
  String $install_path    = '/usr/local/bin',
  String $server_version  = 'current',
  String $client_version  = 'current',
){

  if ( $manage_user ) {
    group { $group:
      ensure => present,
      system => true,
    }
    user { $user:
      ensure     => present,
      gid        => $group,
      home       => $storage_dir,
      system     => true,
      require    => Group[$group],
    }
  }

  file {[$config_dir, $storage_dir]:
    ensure  => directory,
    owner   => $user, group => $group, mode => "0755",
    require => $manage_user ? { true => User[$user], default => undef }
  }

  minio::install::server{"default":
    version => $server_version,
  }

  minio::install::client{"default":
    version       => $client_version,
  }
}