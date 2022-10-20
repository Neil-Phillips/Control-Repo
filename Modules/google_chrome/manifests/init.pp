class google_chrome (
  $ensure                 = $google_chrome::params::ensure,
  $version                = $google_chrome::params::version,
  $package_name           = $google_chrome::params::package_name,
  $repo_gpg_key           = $google_chrome::params::repo_gpg_key,
  $repo_gpg_key_id        = $google_chrome::params::repo_gpg_key_id,
  $repo_name              = $google_chrome::params::repo_name,
  $defaults_file          = $google_chrome::params::defaults_file,
  $defaults_proxy_pac_url = $google_chrome::params::defaults_proxy_pac_url,
  $repo_base_url          = $google_chrome::params::repo_base_url,
  $proxy_url              = $google_chrome::params::proxy_url,
  $toolstation_together   = $google_chrome::params::toolstation_together,
  $toolstation_together_auto = $google_chrome::params::toolstation_together_auto,
  $install_overide        = $google_chrome::params::install_overide,

) inherits google_chrome::params {

  if $lsbdistrelease != '12.04' {
    validate_re($version, ['^stable','^unstable','^beta'])

    if ( $_hostname =~ 'manager' or $install_overide ) {

    anchor { 'google_chrome::begin': }  -> 
    class { 'google_chrome::config': }  -> 
    class { 'google_chrome::install': }  -> 
    class { 'google_chrome::launchers': }  ->
    anchor { 'google_chrome::end': }

    }
  }
}
