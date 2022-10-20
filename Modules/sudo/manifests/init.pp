#
class sudo {

  anchor { 'sudo::begin': } ->
  class { '::sudo::package': } ->
  anchor { 'sudo::end': }

}
