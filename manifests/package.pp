class zookeeper::package inherits zookeeper::params {
  $version      = $zookeeper::version
  $download_url = "${zookeeper::params::download_url_base}/zookeeper-$version/zookeeper-$version.tar.gz"
  $zk_dir       = $zookeeper::zk_dir
  $user         = $zookeeper::user
  $group        = $zookeeper::group





  package { 'zookeeper':
    ensure => $version,
  }

### don't install nc
#  package {'nc':
#    ensure => present,
#  }



}
