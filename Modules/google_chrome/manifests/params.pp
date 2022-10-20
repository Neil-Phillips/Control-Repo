class google_chrome::params() {
  $ensure                 = 'latest'
  $version                = 'stable'
  $package_name           = 'google-chrome'
  $repo_gpg_key           = 'https://dl.google.com/linux/linux_signing_key.pub'
  $repo_gpg_key_id        = '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991'
  $repo_name              = 'google-chrome'
  $defaults_file          = '/etc/default/google-chrome'
  $defaults_proxy_pac_url = undef
  $proxy_url              = undef
  $toolstation_together   = false
  $toolstation_together_auto = false

  $_hostname = downcase($hostname)

# If true, puppet will install the package on any machine
  $install_overide  = false

  case $::osfamily {
    'Ubuntu': {
      $repo_base_url = '[arch=amd64] http://dl.google.com/linux/chrome/deb/'
    }
    'Debian': {
      $repo_base_url = '[arch=amd64] http://dl.google.com/linux/chrome/deb/'
    }
    default: {
      fail("Unsupported operating system family ${::osfamily}")
    }
  }
}
