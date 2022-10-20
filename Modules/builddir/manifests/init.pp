# Essential directory used buy some classes to store build data

class builddir (

  $location = $builddir::params::location,

  ) inherits builddir::params {

# Create the build directory

  file { "${location}":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

}
