class php5 {
    package { ["libapache2-mod-php5", "php5-mysql", "php5-cli", "php5-gd", "php5-imagick", "php5-mcrypt", "php5-sqlite", "php5-curl", "php5-pgsql" ]: 
        ensure  => present,
        require => Package['apache2'],
        notify  => Service['apache2'];
    }

    file { "php5_file_upload_settings":
        ensure=> present,
        path    => "/etc/php5/apache2/conf.d/upload.ini",
        source  => "puppet:///modules/php5/upload.ini",
        notify  => Service["apache2"],
        require => Package["libapache2-mod-php5"],
    }
}
