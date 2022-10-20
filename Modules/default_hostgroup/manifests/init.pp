#
class default_hostgroup {

  anchor { 'default_hostgroup::begin': } ->
  class { '::default_hostgroup::config': } ->
  class { '::default_hostgroup::service': } ->
  anchor { 'default_hostgroup::end': }

}
