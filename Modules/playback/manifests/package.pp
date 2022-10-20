#
class playback::package inherits playback {

  package { 'pavucontrol':
    ensure => latest,
  }
  package { 'pulseaudio':
    ensure => latest,
  }
  package { 'pulseaudio-utils':
    ensure => latest,
  }
  package { 'alsa-base':
    ensure => latest,
  }
  package { 'vlc':
    ensure => latest,
  }
}
