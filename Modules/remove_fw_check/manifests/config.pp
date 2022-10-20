class remove_fw_check::config inherits remove_fw_check {

file { '/usr/local/bin/firewallcheck.sh':
        ensure => absent,
     }

}

