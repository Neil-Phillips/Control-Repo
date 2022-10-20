#
class pi_init () {

  anchor { 'pi_init::begin': } ->
   class { '::pi_init::config': } ->
   class { '::pi_init::service': } ->
   anchor { 'pi_init::end': }
}
