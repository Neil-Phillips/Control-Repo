#
class chromium::settings inherits chromium {

  if $chromium_sysprefs != undef {

    if $hostgroup =~ /Default.Shops/ or $hostgroup =~ /Warehouse.Redditch/ or $hostgroup =~ /Warehouse.Daventry/ or $hostgroup =~ /Warehouse.Middleton/ {

      file_line { 'chromium aws proxy':
        ensure => absent,
        path   => '/etc/chromium-browser/policies/managed/default-policy.json',
        line   => '  "ProxyPacUrl": "http://proxy.aws.toolstation.com/shop.pac",',
      }
      file_line { 'chromium aws proxy mode 1/2':
        ensure => absent,
        path   => '/etc/chromium-browser/policies/managed/default-policy.json',
        line   => '  "ProxyMode": "pac_script",',
      }
      file_line { 'chromium aws proxy mode 2/2':
        ensure => absent,
        path   => '/etc/chromium-browser/policies/managed/default-policy.json',
        line   => '"ProxyMode": "direct",',
      }
      file_line { 'chromium aws proxy mode direct':
        ensure => present,
        path   => '/etc/chromium-browser/policies/managed/default-policy.json',
        after  => '  "SavingBrowserHistoryDisabled": true,',
        line   => '  "ProxyMode": "direct",',
      }
    }
  }
}

