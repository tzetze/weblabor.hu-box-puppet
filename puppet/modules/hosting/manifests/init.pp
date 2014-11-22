class hosting {
    $root_dir = "/var/www"

    file { "$root_dir":
        ensure => directory,
        group  => "www-data",
        owner  => "www-data",
    }
}