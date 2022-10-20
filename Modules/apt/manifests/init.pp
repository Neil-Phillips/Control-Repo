#
class apt (

  $proxy_url        = $apt::params::proxy_url,
  $override         = $apt::params::override,

) inherits apt::params {

     anchor { 'apt::begin': } ->
     class { '::apt::update': } ->
     anchor { 'apt::end': }

}
