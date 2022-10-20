class test {
  file { "/home/testfile.test":
    source => "puppet:///modules/test/testfile.test",
  }
}
