#
class fix_pi_name {

  if $fqdn =~ "TSUKRP0028-Rastelly" {

    anchor { 'fix_pi_name::begin': } ->
    class { '::fix_pi_name::cronhourly': } ->
    anchor { 'fix_pi_name::end': }
 }

}
