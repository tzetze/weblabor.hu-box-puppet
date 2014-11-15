class mysql {
    $mysqladmin = "/usr/bin/mysqladmin"
    $mysql      = "/usr/bin/mysql"

    include mysql::backup
    include mysql::configuration

    package { "mysql-server":
        ensure => installed,
    }

    service { "mysql":
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => [ Package["mysql-server"] ]
    }

    exec { "mysql-reload-privileges":
        command =>     "${mysql} -NBe 'FLUSH PRIVILEGES'",
        refreshonly => true
    }
}