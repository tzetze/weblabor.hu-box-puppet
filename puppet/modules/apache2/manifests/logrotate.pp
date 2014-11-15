class apache2::logrotate {
    file { "apache2-logrotate-conf":
        path => "/etc/logrotate.d/apache2",
        ensure => "file",
        source => "puppet:///modules/apache2/logrotate-apache2",
        owner => "root",
        group => "root",
    }
}