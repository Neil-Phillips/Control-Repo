#
class chromium inherits chromium::params {

# if ( $lsbdistrelease != '12.04' and $lsbdistrelease != '14.04' ) {
 if ( $lsbdistrelease != '12.04' ) {

#   if $_hostname !~ 'till' {
#   if $_hostname =~ 'till1' or $_hostname =~ 'till3' or $_hostname =~ 'till5' or $_hostname =~ 'till7' {
     anchor { 'chromium::begin': } ->
     class { '::chromium::package': } ->
     class { '::chromium::launchers': } ->
     class { '::chromium::settings': } ->
     anchor { 'chromium::end': }
     }
#  }

}
