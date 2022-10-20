#
class yum inherits yum::params {

 if $lsbdistid == "Amazon" {
     anchor { 'yum::begin': } ->
     class { '::yum::package': } ->
     class { '::yum::update': } ->
     anchor { 'yum::end': }
  }

}
