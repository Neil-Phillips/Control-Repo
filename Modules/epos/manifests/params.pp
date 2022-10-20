#
class epos::params {

# Boolean to switch between the old 'whole app upload' and the new 'incremental patch' mode 16-03-20 MH
  $patch            = true

  # Developer tools alt+ctrl+shift+i

  # Current version.
  $version          = '4.0.3'  # Version of the epos application to deploy
  $active_version   = '4.0.3'  # Version of the epos application the symlink points at (update version to allow latest release to deploy)
  # Previous version of EPOS - e.g. the one the patch was created against.
  $previous_version = '4.0.2'
  $architecture     = 'x86_64'
  $epos_filetype    = 'AppImage'

#  $previous_filename = "epos-${previous_version}-${$architecture}.${epos_filetype}"
#  $version_filename  = "epos-${version}-${$architecture}.${epos_filetype}"

# Split the CouchDB URL up 
  $cdbuser          = ''                                                                              # CouchDB Username
  $cdbpass          = ''                                                                              # CouchDB Password
  $cdbserver        = '08d1ad8c-de1d-45ee-9145-a2267ef45e57-bluemix.cloudantnosqldb.appdomain.cloud'  # CouchDB server to connect to
  $cdbport          = '6984'                                                                          # CouchDB Port number
  $couchdburl       = "https://${cdbuser}:${cdbpass}@${cdbserver}/"  # This is the above combined
# $couchdburl       = "https://${cdbuser}:${cdbpass}@${cdbserver}:${cdbport}/"  # This is the above combined

# API Bits
  $apiurl           = 'https://api.toolstation.com'
  $apiclientid      = '1'                                                           # EPOS API Client ID
  $apiclientsecret  = ''                                                            # EPOS API Client Secret
  $bloomreachproxyurl = 'https://internal-search.gke.internal.toolstation.com/api'

  $package_location = '/usr/local/epos'   # Where to store the package
  $patch_location   = '/usr/local/epos/patch'
  $local_storage    = '/var/lib/pouchdb'  # Where PouchDB data is stored
  $epos_storage     = '/var/lib/epos'     # Like above but used to set APP_DIRECTORY
  $pdqip            = undef               # Allows the IP of the PDQ to be overridden
  $rsyncip          = undef               # Where the rsync should come from
  $enable_icon      = false               # Should the taskbar be updated with the icon

# If true, puppet will install the package on any machine
  $install_overide  = false  

# Proxy config
  $proxy_url        = ''

# Extract octets of the ipaddress
  $net              = regsubst($::ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\1.\2.\3')
  $i1               = regsubst($::ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\1')
  $i2               = regsubst($::ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\2')
  $i3               = regsubst($::ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\3')
  $i4               = regsubst($::ipaddress,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$','\4')

# Convert the location to UPPERCASE (because the app needs it this way)
  $_fqdn            = downcase($fqdn)
  if ( $_fqdn =~ "returns" and $_fqdn =~ ".bdc." ) or $_fqdn =~ "warehouse.ws" or $_fqdn =~ "hq.toolstation.com" {
    $till_location    = 'CC'
  } else {
    $till_location    = upcase($location_new)
  }
#  notify{"Till location is ${till_location}":}

# Used to set which is the 'master' till for the package
  $id               = ['till1']
# Convert the hostname to LOWERCASE (so the above works - no consistency in naming convention)
  $_hostname        = downcase($hostname)

}
