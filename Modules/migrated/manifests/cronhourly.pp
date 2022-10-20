#
class migrated::cronhourly inherits migrated {

  file { '/etc/cron.hourly/migrate_puppet_master':
    ensure => absent,
  }

  if $::puppet_server == 'puppet-proxy.support.toolstation.com' {

    file { '/etc/cron.hourly/migrate_puppet_master_legacy':
      ensure => absent,
    }

  }

}
