define minio::install::server (
  String  $version    = 'current',
) {
  require archive

  if ( $version == 'current' or $version == 'latest' ) {
    $source     = "https://dl.min.io/server/minio/release/linux-amd64/minio"
    $dest       = "${minio::install_dir}/opy/minio/bin/minio"
  } else {
    if ( ! $version =~ /^RELEASE\.(\d+)-(\d+)-(\d+)T(\d+)-(\d+)-(\d+)Z/ ) {
      fail("Invalied version (!~ RELEASE.\d+-\d+-\d+T\d+-\d+-\d+Z)")
    }
    $source = "https://dl.min.io/server/minio/release/linux-amd64/archive/minio.${version}"
    $dest   = "${minio::install_dir}/bin/minio.${version}"
  }

  archive::download { "$dest":
    ensure        => present,
    checksum      => true,
    url           => "${source}",
    digest_url    => "${source}.sha256sum",
    digest_type   => 'sha256',
    creates       => $version == 'latest' ? { true => true, default => false }
  }

  file {"${installation_directory}/minio":
    owner   => $owner, group => "root", mode  => '0755',
    require => archive::download["$dest"]
  }
}