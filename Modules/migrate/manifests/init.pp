#
class migrate {

  anchor { 'migrate::begin': } ->
  class { '::migrate::cronhourly': } ->
  anchor { 'migrate::end': }

}
