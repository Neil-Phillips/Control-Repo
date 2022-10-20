#
class fix_pi_name::cronhourly inherits fix_pi_name {

  file { '/etc/cron.hourly/fix_pi_name':
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/fix_pi_name/fix_pi_name.sh'
  }


}
