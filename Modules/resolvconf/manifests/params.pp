#
class resolvconf::params {

  $nameserver = ['8.8.8.8','8.8.4.4']
# Convert the hostname to LOWERCASE (so the above works - no consistency in naming convention)
  $_hostname        = downcase($hostname)

}
