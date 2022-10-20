#
class migrate::cronhourly inherits migrate {

  if $::lsbdistrelease == '14.04' or $::lsbdistrelease == '16.04' or $::lsbdistrelease == '18.04' {

    file { '/etc/cron.hourly/migrate_puppet_master_legacy':
      owner  => root,
      group  => root,
      mode   => '0755',
      source => 'puppet:///modules/migrate/migrate_puppet_master_legacy.sh',
    }

  }

}
