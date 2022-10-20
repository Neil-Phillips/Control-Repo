#
# needs apt-transport-https
 
class filebeat::package inherits filebeat {

  package { 'filebeat':
    require => Class['::filebeat::key'],
  }

}
