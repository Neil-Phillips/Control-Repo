#
class sysinfo::config inherits sysinfo {

    file { '/usr/local/bin/SysInfo.sh':
      owner  => root,
      group  => root,
      mode   => '0755',
      content => template('sysinfo/SysInfo.sh.erb')
  }
    file { '/usr/local/bin/external.py':
      owner  => root,
      group  => root,
      mode   => '0755',
      content => template('sysinfo/external.py.erb')
  }

}
