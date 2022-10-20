#
class mcollective {

  service { 'mcollective':
    ensure     => stopped,
    enable     => false,
  }

}
