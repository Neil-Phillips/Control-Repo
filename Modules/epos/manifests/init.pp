#
class epos (

  $version          = $epos::params::version,
  $previous_version = $epos::params::previous_version,
  $active_version   = $epos::params::active_version,
  $couchdburl       = $epos::params::couchdburl,
  $apiurl           = $epos::params::apiurl,
  $apiclientid      = $epos::params::apiclientid,
  $apiclientsecret  = $epos::params::apiclientsecret,
  $bloomreachproxyurl = $epos::params::bloomreachproxyurl,
  $local_storage    = $epos::params::local_storage,
  $pdqip            = $epos::params::pdqip,
  $rsyncip          = $epos::params::rsyncip,
  $enable_icon      = $epos::params::enable_icon,
  $install_overide  = $epos::params::install_overide,
  $enabled          = false,
  $proxy_url        = $epos::params::proxy_url,
  $patch            = $epos::params::patch,

  ) inherits epos::params {


#  -lr is the partial name for a laptop configured for EPOS trinaing - see Luke Bale

  if $enabled {
    if $_hostname =~ 'till' or $_hostname =~ 'returns' or $_hostname =~ '-lr' or $_hostname =~ 'warehouse' or $_hostname =~ 'pioffice' or $domain =~ 'ws.toolstation.shop' or $domain =~ 'r2.toolstation.shop' or $domain =~ 'bdc.toolstation.com' or $domain =~ 'workspaces.toolstation.com' or $domain =~ 'hq.toolstation.com' {

      anchor { 'epos::begin': } ->
      class { '::epos::package': } ->
      class { '::epos::config': } ->
      class { '::epos::icons': } ->
#      class { '::epos::rsync': } ->
      anchor { 'epos::end': }

    }
  }

}
