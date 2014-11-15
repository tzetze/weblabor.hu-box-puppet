class apache2 {

    $available_dir = "/etc/apache2/sites-available"
    $enabled_dir   = "/etc/apache2/sites-enabled"

    include apache2::ssl
    include apache2::status
    include apache2::logrotate

    package { ["apache2", "apache2-mpm-prefork"]: 
        ensure => present,
    }

    service { "apache2":
        hasstatus => true,
        hasrestart => true,
        ensure => running,
        require => Package["apache2"],
    }

    Exec["force-reload-apache"] { command => "/etc/init.d/apache2 force-reload", }

    exec { "force-reload-apache":
        refreshonly => true,
        before => Service["apache2"],
    }

    apache2::module { ["rewrite", "proxy", "proxy_http", "headers"]: 
        ensure => 'present'
    }

    file { "apache2-config-noindex":
        path => "/etc/apache2/conf-enabled/noindex",
        ensure => "file",
        source => "puppet:///modules/apache2/config-noindex",
        notify => Service["apache2"],
        require => Package["apache2"],
    }

    file { "apache2-config-ports":
        path => "/etc/apache2/ports.conf",
        ensure => "file",
        content => template("apache2/ports.conf.erb"),
        notify => Service["apache2"],
        require => Package["apache2"],
    }
}
