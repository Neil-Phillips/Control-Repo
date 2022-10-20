#
define default_hostgroup::group (

  String $group,
  String $factname = '',
  String $domain   = '',
  Array $depotid  = [],
  String $fqdn     = '',

  ) {

  concat::fragment{"hostgroup_${name}":
    target  => '/etc/foreman/plugins/default_hostgroup.yaml',
    content => template('default_hostgroup/append_group.erb'),
    order   => '10'
  }

}
