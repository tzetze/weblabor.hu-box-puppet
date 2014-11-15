class trac {
    package { ["python", "libapache2-mod-python", "python-dev", "python-setuptools", "python-pkg-resources", "python-software-properties", ]:
        ensure  => latest,
        require => Package["apache2"],
        notify  => Service["apache2"];
    }

    python::easyinstall { ["pytz", "Genshi", "Babel", "Pygments", "Trac"]:
        ensure => "present",
        require => Package["python"]
    }

    file { "trac-datadir":
        path => "/var/trac",
        ensure => "directory",
        owner => "www-data",
        group => "www-data",
    }
}
