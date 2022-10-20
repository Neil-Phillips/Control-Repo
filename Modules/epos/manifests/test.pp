#
class epos::test inherits epos {

# Just some tests.

  $id = ['test','electron']
  $_hostname = downcase($hostname)

  if $id != [] {
    # Do some shit and loop through
    $id.each |$name | {
      if $_hostname =~ $name {
        notify{"Match found: ${_hostname} is like: ${name}":}
      }
    }

  }

}
