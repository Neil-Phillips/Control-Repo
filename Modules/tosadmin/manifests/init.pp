#
class tosadmin {

## Ditch the tosadmin cron if it exists

  exec { 'remove-tosadmin':
    command     => "/bin/sed -i '/tosadmin/d' /etc/crontab",
    logoutput   => false,
    onlyif      => '/bin/grep -c tosadmin /etc/crontab',
  }

}
