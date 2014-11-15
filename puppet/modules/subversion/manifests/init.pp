class subversion {
    package { ["subversion", "libapache2-svn", "subversion-tools", "svnmailer"]: 
        ensure  => latest,
        require => Package['apache2'],
        notify  => Service['apache2'];
    }

    file { "svn-datadir":
        path => "/var/svn",
        ensure => "directory",
        owner => "www-data",
        group => "www-data",
    }

    apache2::module { ["authz_svn"]:
        ensure => 'present',
        require => Package['libapache2-svn']
    }
}
