#
class filebeat::params {

  $server_ip     = 'taiga.owta.net'
  $crt           = 'taiga.owta.net.crt'
  $key           = 'taiga.owta.net.key'
  $ca            = 'ca.crt'
  $crt_path      = '/etc/ssl/certs'
  $key_path      = '/etc/ssl/private'
  $logstash_crt  = "${crt_path}/${crt}"
  $logstash_key  = "${key_path}/${key}"
  $logstash_ca   = "/etc/filebeat/ssl/${ca}"
  $system_mod    = true
  $apache_mod    = hiera('filebeat::apache_mod',false)
  $logstash_mod  = false
  $uupdates_pros = false
  $prospectors   = hiera_array('filebeat::prospectors',[])

  $_hostname        = downcase($hostname)

}
