#
class default_hostgroup::config inherits default_hostgroup {

  concat { '/etc/foreman/plugins/default_hostgroup.yaml':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['foreman'],
  }

  concat::fragment{'hostgroup_header':
    target  => '/etc/foreman/plugins/default_hostgroup.yaml',
    order   => '01',
    content => template('default_hostgroup/default_hostgroup.yaml.erb'),
    notify  => Service['foreman'],
  }

  $group = hiera_hash('default_hostgroup::group', {})
  create_resources('default_hostgroup::group', $group)

  concat::fragment{'hostgroup_footer':
    target  => '/etc/foreman/plugins/default_hostgroup.yaml',
    order   => '15',
    content => template('default_hostgroup/default_hostgroup_footer.erb'),
    notify  => Service['foreman'],
  }

}
