#
class epos::icons inherits epos {

# Launcher Script - if switching to this, don't forget to modify the EPOS_app.desktop Exec line

  file { '/usr/local/bin/launchers':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/usr/local/bin/launchers/EPOS_app.sh':
    owner  => root,
    group  => root,
    mode   => '0755',
    content => template('epos/launchers/EPOS_app.sh.erb'),
  }

# EPOS App Icon

  file { '/usr/share/applications/EPOS_app.desktop':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/epos/xfce4/EPOS_app.desktop',
  }

# Update the epos Task Bar

  if $enable_icon {
    file { '/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml.epos':
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///modules/epos/xfce4/xfce4-panel.xml.epos',
    }
    file { '/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml.warehouse':
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///modules/epos/xfce4/xfce4-panel.xml.warehouse',
    }
    file { '/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml.packing':
      owner  => root,
      group  => root,
      mode   => '0644',
      source => 'puppet:///modules/epos/xfce4/xfce4-panel.xml.packing',
    }
  }

  file { '/usr/share/pixmaps/trolley_black.png':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/epos/xfce4/trolley_black.png',
  }

# Old EPOS removal, Mark Howard 05/08/2020
  file { '/usr/share/pixmaps/EPOS.png':
        ensure => absent,
  }
  file { '/usr/share/applications/EPOS.desktop':
        ensure => absent,
  }
  file { '/usr/local/bin/chromiumLaunchers/EPOS.sh':
        ensure => absent,
  }
  file { '/etc/xdg/autostart/EPOS.desktop':
        ensure => absent,
  }

# Old Offline EPOS removal, Mark Howard 13/01/2021
  file { '/usr/local/bin/chromiumLaunchers/OfflineTill.sh':
        ensure => absent,
  }
  file { '/usr/share/applications/OfflineTill.desktop':
        ensure => absent,
  }
  file { '/usr/share/pixmaps/Offline.png':
        ensure => absent,
  }
  file { '/usr/share/applications/OfflineTillTSUK.desktop':
        ensure => absent,
  }
  file { '/usr/local/bin/chromiumLaunchers/OfflineTillTSUK.sh':
        ensure => absent,
  }


# Disable integration: touch /usr/share/appimagekit/no_desktopintegration
  file { '/usr/share/appimagekit':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/usr/share/appimagekit/no_desktopintegration':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0444',
  }



}
