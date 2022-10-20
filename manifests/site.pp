node 'dev-test-till.hq.toolstation.com' {
  $location = 'BS'
  include stdlib
  include epos
}

node default {
  include test
}
