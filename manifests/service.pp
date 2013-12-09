class zookeeper::service(
  $ensure = 'running'
) {
  $user       = $zookeeper::user
  $group      = $zookeeper::group
  $dir        = $zookeeper::zk_dir
  $log_dir    = $zookeeper::log_dir
  $data_dir   = $zookeeper::data_dir
  $etc_dir    = $zookeeper::etc_dir
  $bin_dir    = $zookeeper::bin_dir
  $log4j_prop = $zookeeper::log4j_prop

  # https://github.com/globocom/zookeeper-centos-6/blob/master/redhat/zookeeper.init
  # first time before untarring ZK, this isn't available:
  # TODO: solve this ordering problem
  $classpath = globby_join("$bin_dir/{../lib,..}/*.jar", ':')
  $log_conf = 'file:///etc/zookeeper/log4j.properties'

  supervisor::service { 'zookeeper':
    ensure      => $ensure,
    user        => $user,
    group       => $group,
    directory   => $data_dir,
    command     => "/usr/bin/java -Dzookeeper.log.dir=${log_dir} -Dlog4j.configuration=$log_conf \
-Dzookeeper.root.logger=${log4j_prop} -cp $classpath org.apache.zookeeper.server.quorum.QuorumPeerMain \
${etc_dir}/zoo.cfg",
  }
}

# \"-Dzookeeper.log.dir=${ZOO_LOG_DIR}\" \"-Dzookeeper.root.logger=${ZOO_LOG4J_PROP}\" -cp ${CLASSPATH} ${ZOOMAIN} ${ZOOCFG}