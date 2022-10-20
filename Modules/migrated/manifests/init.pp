#
class migrated {

    anchor { 'migrated::begin': } ->
    class { '::migrated::cronhourly': } ->
    anchor { 'migrated::end': }
}
