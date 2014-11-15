class apache2::status {
    package { "links": 
        ensure => present,
    }
    apache2::module { "status":
        ensure => present,
    }
}