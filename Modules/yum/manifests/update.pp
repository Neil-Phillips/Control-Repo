#
class yum::update inherits yum {

      file { '/etc/yum/yum-cron.conf':
        owner    => root,
        group    => root,
        mode     => '0755',
        content => template('yum/yum-cron.conf.erb'),
      }
}
