#
class sysinfo::params {

# Convert the hostname to LOWERCASE (so the above works - no consistency in naming convention)
  $_hostname        = downcase($hostname)

}
