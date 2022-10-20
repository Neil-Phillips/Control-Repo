class apt::params {

  $proxy_url        = ''
  $_fullname        = downcase($fqdn)
# If true, puppet will update the sources to the internet ones
  $override  = false

}
