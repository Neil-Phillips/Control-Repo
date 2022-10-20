node 'tos-devtill1.zz.toolstation.shop' {
  $location = 'zz'
  include stdlib
  include epos
  include google_chrome
}

node default {
  include test
}
