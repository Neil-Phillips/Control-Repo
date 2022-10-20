#
class epos::package_install inherits epos {

# New Skool
  if $patch {
    $patch_file = "epos-${previous_version}-${version}-${architecture}.patch"
    $version_filename  = "epos-${version}-${$architecture}.${epos_filetype}"
    $previous_filename = "epos-${previous_version}-${$architecture}.${epos_filetype}"
    # Adding the base, unpatched EPOS.
    package { 'xdelta3':
      ensure   => installed,
      provider => apt,
    }
    file { "${package_location}/${previous_filename}":
      owner   => root,
      group   => root,
      mode    => '0755',
      require => File[$package_location],
      source  => "puppet:///modules/epos/AppImage/${previous_filename}",
    }
    file { "${patch_location}/$patch_file":
      owner   => root,
      group   => root,
      mode    => '0755',
      require => File[$patch_location],
      source  => "puppet:///modules/epos/AppImage/patch/${patch_file}",
    }
    exec { "xdelta3 -d -s ${package_location}/${previous_filename} ${patch_location}/${patch_file} ${package_location}/${version_filename}":
      path    => "/usr/bin",
      creates => "${package_location}/${version_filename}",
#      onlyif  => "xdelta3 -v",
    }
    file { "${package_location}/${version_filename}":
      owner   => root,
      group   => root,
      mode    => '0755',
      require => File[$package_location],
    }
    tidy { "${package_location}/${previous_filename}": }
  }
  else {
# Old Skool
# Deploy the package based on the version set
# Direct from puppet master

    file { "${package_location}/epos-${version}-x86_64.AppImage":
      owner   => root,
      group   => root,
      mode    => '0755',
      require => File[$package_location],
      source  => "puppet:///modules/epos/AppImage/epos-${version}-x86_64.AppImage",
    }
  }
}
