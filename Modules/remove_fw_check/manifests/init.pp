class remove_fw_check {

  anchor { 'remove_fw_check::begin': } ->
#  class { '::remove_fw_check::config': } ->
  anchor { 'remove_fw_check::end': }

}
