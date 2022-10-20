#
class dnsutils {

  anchor { 'dnsutils::begin': } ->
  class { '::dnsutils::package': } ->
  anchor { 'dnsutils::end': }

}
