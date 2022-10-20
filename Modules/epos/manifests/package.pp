#
class epos::package inherits epos {

# Create the folder for the package to go in
  file { $package_location:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  # Create the folder for the patch to go in
  if $patch {
    file { $patch_location:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    }
  }

  include epos::package_install

# Link to the active version used by the desktop launcher
  file { '/usr/local/bin/epos.AppImage':
    ensure => link,
    target => "${package_location}/epos-${active_version}-x86_64.AppImage",
  }

}
