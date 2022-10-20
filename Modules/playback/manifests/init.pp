#
class playback (
  $install_overide        = $playback::params::install_overide,
) inherits playback::params {
  if ( $_hostname =~ 'manager'  or $install_overide ) {
    anchor { 'playback::begin': } ->
    class { '::playback::package': } ->
    anchor { 'playback::end': }
  }
}
