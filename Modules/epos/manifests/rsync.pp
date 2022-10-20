#
class epos::rsync inherits epos {

# If the till name matches the $id array, the rsync::epos class will be installed (this should be till1 only)

  if $id != [] {
    # Loop through the hostnames in the array above
    $id.each |$name | {
      if $_hostname =~ $name {

        # include this class
        include rsync::epos

      }
    }

  }

}
