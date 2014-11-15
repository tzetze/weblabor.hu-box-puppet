define apache2::module ( $ensure = 'present', $require_package = 'apache2' ) {
    case $ensure {
        'present' : {
            exec { "/usr/sbin/a2enmod $name":
                unless => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
                && [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
                notify => Exec["force-reload-apache"],
                require => Package[$require_package],
            }
        }
        'absent': {
            exec { "/usr/sbin/a2dismod $name":
                onlyif => "/bin/sh -c '[ -L /etc/apache2/mods-enabled/${name}.load ] \\
                && [ /etc/apache2/mods-enabled/${name}.load -ef /etc/apache2/mods-available/${name}.load ]'",
                notify => Exec["force-reload-apache"],
                require => Package[$require_package],
            }
        }
    }
}