#
class chromium::launchers inherits chromium {

#      file { '/usr/local/bin/chromiumLaunchers':
#        ensure => directory,
#        owner  => root,
#        group  => root,
#        mode   => '0755',
#      }

#
#     Middleton only

      if $fqdn =~ /ms.toolstation.shop/ {
        file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
          owner    => root,
          group    => root,
          mode     => '0755',
          content => template('chromium/launchers/Extranet.sh.erb'),
        }
      }

      if $hostgroup =~ /Warehouse.Daventry/ {
        if $extranet_sh != undef {
          file_line { 'Extranet old aws proxy':
            ensure => absent,
            path   => '/usr/local/bin/chromiumLaunchers/Extranet.sh',
            line   => 'proxyPacLocation=http://proxy.aws.toolstation.com/shop.pac',
          }
        }
      }

      if $hostgroup =~ /Warehouse.Redditch/ {
        if ($_fullname =~ /goodsin.rs/ or $_fullname =~ /replen.rs/ ) {
          file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
            owner    => root,
            group    => root,
            mode     => '0755',
            content => template('chromium/launchers/Extranet_Redditch_Packing.sh.erb'),
          }
        } else {
           file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
            owner    => root,
            group    => root,
            mode     => '0755',
            content => template('chromium/launchers/Extranet_shop.sh.erb'),
          }
        }
      }
#      if ($_fullname =~ /packingwx/ ) {
#          file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
#            owner    => root,
#            group    => root,
#            mode     => '0755',
#            content => template('chromium/launchers/Extranet_WX.sh.erb'),
#          }
#      }
#      if ($_fullname =~ /packingwy/ ) {
#          file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
#            owner    => root,
#            group    => root,
#            mode     => '0755',
#            content => template('chromium/launchers/Extranet_WY.sh.erb'),
#          }
#      }
      if ($_fullname =~ /pack/ and $hostgroup !~ /Warehouse.Redditch/) {
          file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
            owner    => root,
            group    => root,
            mode     => '0755',
            content => template('chromium/launchers/Extranet_PackingBench.sh.erb'),
          }
      }

      file { '/usr/local/bin/chromiumLaunchers/corehr.sh':
        owner    => root,
        group    => root,
        mode     => '0755',
        content => template('chromium/launchers/corehr.sh.erb'),
      }

      file { '/usr/share/applications/corehr.desktop':
        owner  => root,
        group  => root,
        mode   => '0755',
        source => 'puppet:///modules/chromium/corehr.desktop',
      }

       file { '/usr/local/bin/chromiumLaunchers/Email.sh':
        owner    => root,
        group    => root,
        mode     => '0755',
        content => template('chromium/launchers/Email.sh.erb'),
      }

#
#     Only apply the following to tills and manager PCs 
#

#     if $_hostname =~ 'till' or $_hostname =~ 'manager' or $_hostname =~ 'Manager' {

       file { '/usr/local/bin/chromiumLaunchers/Website.sh':
           owner    => root,
           group    => root,
           mode     => '0755',
           content => template('chromium/launchers/Website.sh.erb'),
       }
 
#       file { '/usr/local/bin/chromiumLaunchers/gsuite.sh':
#           owner    => root,
#           group    => root,
#           mode     => '0755',
#           content => template('chromium/launchers/gsuite.sh.erb'),
#       }
 
#       file { '/usr/local/bin/chromiumLaunchers/Extranet.sh':
#           owner    => root,
#           group    => root,
#           mode     => '0755',
#           content => template('chromium/launchers/Extranet_shop.sh.erb'),
#       }
#    }

}

