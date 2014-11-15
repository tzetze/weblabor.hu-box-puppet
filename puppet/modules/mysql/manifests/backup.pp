class mysql::backup {

    file { "mysql-dump-dir":
        path => "/var/sqldump",
        ensure => "directory",
    }

    file { "mysql-dump-script":
        path   => "/usr/local/sbin/mysqldump.sh",
        ensure => "present",
        source => "puppet:///modules/mysql/mysqldump.sh",
        mode   => 0755,
    }

    cron { "mysql-dump-cronjob":
        command => "/usr/local/sbin/mysqldump.sh",
        user => "root",
        hour => 0,
        minute => 15,
    }
}