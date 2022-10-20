class google_chrome::launchers inherits google_chrome {

      if $_hostname =~ 'till' {
        file { '/usr/local/bin/chromiumLaunchers':
          ensure => directory,
          owner  => root,
          group  => root,
          mode   => '0755',
        }
      }

#
#     Only apply the following to tills and manager PCs 


       if ($_hostname =~ 'till' or $_hostname =~ 'manager' or $_hostname =~ 'Manager') and $_hostname !~ 'shiftmanager'  {
 
         file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
             owner    => root,
             group    => root,
             mode     => '0755',
             content => template('google_chrome/launchers/Extranet_shop.sh.erb'),
         }
      }

      if ($_hostname =~ 'manager') and ($toolstation_together) {
        file { '/usr/local/bin/chromiumLaunchers/ToolstationTogether.sh':
          owner    => root,
          group    => root,
          mode     => '0755',
          content => template('google_chrome/launchers/ToolstationTogether.sh.erb'),
        }

        file { '/usr/share/applications/toolstationtogether.desktop':
          owner  => root,
          group  => root,
          mode   => '0755',
          source => 'puppet:///modules/google_chrome/toolstationtogether.desktop',
        }
        $_toolstation_together_auto = $toolstation_together_auto ? {
          true  => 'present',
          false => 'absent',
        }
        file { '/etc/xdg/autostart/toolstationtogether.desktop':
          ensure => $_toolstation_together_auto,
          target => '/usr/share/applications/toolstationtogether.desktop',
        }
      }

# Temporarily commented out Sun 14/3/21  Mark Howard

      file { '/usr/local/bin/chromiumLaunchers/gsuite.sh':
        owner    => root,
        group    => root,
        mode     => '0755',
        content => template('google_chrome/gsuite.sh.erb'),
      }

      file { '/usr/share/pixmaps/gsuite.png':
        owner  => root,
        group  => root,
        mode   => '0755',
        source => 'puppet:///modules/google_chrome/gsuite.png',
      }

       file { '/usr/share/applications/gsuite.desktop':
        owner  => root,
        group  => root,
        mode   => '0755',
        source => 'puppet:///modules/google_chrome/gsuite.desktop',
      }

        file { '/usr/share/applications/google-chrome.desktop':
        ensure => absent,
      }
}
