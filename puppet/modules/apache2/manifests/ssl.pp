class apache2::ssl {
    $cert_dir = "/etc/apache2/ssl"

    apache2::module { "ssl":
        ensure => 'present',
        require => Package["apache2"],
    }

    file { "apache2-ssl-certificate-dir":
        path => "${apache2::ssl::cert_dir}",
        ensure => "directory",
        require => Package["apache2"],
    }

    file { "apache2-ssl-weblabor.hu-key":
        path => "${apache2::ssl::cert_dir}/weblabor.hu.key",
        ensure => "file",
        source => "puppet:///modules/apache2/ssl/weblabor.hu.key",
        require => File["apache2-ssl-certificate-dir"],
    }
    file { "apache2-ssl-weblabor.hu-crt":
        path => "${apache2::ssl::cert_dir}/weblabor.hu.crt",
        ensure => "file",
        source => "puppet:///modules/apache2/ssl/weblabor.hu.crt",
        require => File["apache2-ssl-certificate-dir"],
    }
}