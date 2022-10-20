#
class firefox::settings inherits firefox {

  if $firefox_sysprefs != undef {

    file_line { 'firefox aws proxy':
      ensure => absent,
      path   => '/usr/lib/firefox/defaults/pref/syspref.js',
      line   => 'user_pref("network.proxy.autoconfig_url", "http://proxy.aws.toolstation.com/shop.pac");',
    }
  }
}

