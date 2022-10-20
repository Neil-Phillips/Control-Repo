#
class firefox ( ) {

  anchor { 'firefox::begin': } ->
  class { '::firefox::settings': } ->
  anchor { 'firefox::end': }

}
