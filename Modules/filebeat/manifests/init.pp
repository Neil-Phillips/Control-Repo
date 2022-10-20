#
class filebeat (

  $server_ip     = $filebeat::params::server_ip,
  $logstash_crt  = $filebeat::params::logstash_crt,
  $logstash_key  = $filebeat::params::logstash_key,
  $logstash_ca   = $filebeat::params::logstash_ca,
  $system_mod    = $filebeat::params::system_mod,
  $apache_mod    = $filebeat::params::apache_mod,
  $prospectors   = $filebeat::params::prospectors,
  $uupdates_pros = $filebeat::params::uupdate_pros,
  $disabled      = hiera("filebeat::disabled",true)

  ) inherits filebeat::params {

  $_server_ip = hiera('filebeat::server',$server_ip)

  include puppet::apt_transport_https

  if ! $disabled {

#    exec { 'upgrade-kills':
#      command     => "/bin/kill -9 `/bin/pidof filebeat`;/bin/kill -9 `/bin/pidof filebeat-god`;/usr/bin/touch /var/build/filebeatupgrade;rm /var/lib/filebeat/registry",
#      require     => Class['builddir'],
#      unless      => "/usr/bin/test -f '/var/build/filebeatupgrade'",
#    }

if $_hostname =~ 'till' {
    anchor { 'filebeat::begin': } ->
    class { '::filebeat::key': } ->
    class { '::filebeat::package': } ->
    class { '::filebeat::config': } ->
    class { '::filebeat::service': } ->
    anchor { 'filebeat::end': }
   }
  }

}
