#
class cron ( ) {

  anchor { 'cron::begin': } ->
  class { '::cron::service': } ->
  anchor { 'cron::end': }

}
