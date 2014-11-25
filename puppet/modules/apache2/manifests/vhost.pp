define apache2::vhost(
    $webspace,
    $ensure = "present",
    $variant = "generic",
    $alias_of = false,
    $webroot_dir = false,
    $primary_hosts = [],
    $redirect_hosts = [],
    $webdav_hosts = [],
    $webdav_userspace = ""
) {

    if $alias_of {
        $domain_subdir = $alias_of
    } else {
        $domain_subdir = $name
    }
    $vhost_root            = "${hosting::root_dir}/${webspace}/${domain_subdir}"
    $vhost_id              = "${hosting::root_dir}/${webspace}/${name}"
    $apache_available_file = "${apache2::available_dir}/${name}.conf"
    $apache_enabled_file   = "${apache2::enabled_dir}/${name}.conf"

    case $ensure {
        "present": {

            file { "${apache_available_file}":
                content => template("apache2/vhost_${variant}.erb"),
                ensure  => present,
                require => Package["apache2"],
                notify  => Service["apache2"],
                group   => "root",
                owner   => "root",
            }
            -> file { "${apache_enabled_file}":
                ensure  => link,
                target  => "${apache_available_file}",
                group   => "root",
                owner   => "root",
            }
            if !$alias_of {

                Hosting::Webspace[$webspace] -> File["${vhost_id}"]

                file { "${vhost_id}":
                    path   => "${vhost_root}",
                    ensure => directory,
                    group  => "www-data",
                    owner  => "www-data",
                    mode   => 0770,
                }
                file { "${vhost_id}/www":
                    path   => "${vhost_root}/www",
                    ensure => directory,
                    group  => "www-data",
                    owner  => "www-data",
                    mode   => 0770,
                }
                file { "${vhost_id}/log":
                    path   => "${vhost_root}/log",
                    ensure => directory,
                    group  => "www-data",
                    owner  => "www-data",
                    mode   => 0770,
                }
                file { "${vhost_id}/upload_tmp":
                    path => "${vhost_root}/upload_tmp",
                    ensure => directory,
                    group  => "www-data",
                    owner  => "www-data",
                    mode   => 0770,
                }

                if $webroot_dir {
                    file { "${vhost_id}/www/${webroot_dir}":
                        path    => "${vhost_root}/www/${webroot_dir}",
                        ensure  => directory,
                        group   => "www-data",
                        owner   => "www-data",
                        mode    => 0770,
                    }
                }
            }
        }
        "absent": {

            file { "${apache_available_file}":
                ensure  => absent,
            }
            -> file { "${apache_enabled_file}":
                ensure => absent,
            }

            -> file { "${vhost_root}":
                ensure => absent,
                recurse => true,
                purge => true,
                force => true,
            }
        }
    }
}