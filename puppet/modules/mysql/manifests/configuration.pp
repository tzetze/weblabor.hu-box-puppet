class mysql::configuration {
	$configuration_dir = "/etc/mysql/conf.d"

	file { "mysql-main-config":
		path    => "/etc/mysql/my.cnf",
		source  => "puppet:///modules/mysql/my.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "default-charset":
		path    => "${configuration_dir}/charset.cnf",
		source  => "puppet:///modules/mysql/charset.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "mysqld-safe-config":
		path    => "${configuration_dir}/mysqld_safe.cnf",
		source  => "puppet:///modules/mysql/mysqld_safe.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "mysqld-config":
		path    => "${configuration_dir}/mysqld.cnf",
		source  => "puppet:///modules/mysql/mysqld.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "mysql-client-config":
		path    => "${configuration_dir}/client.cnf",
		source  => "puppet:///modules/mysql/client.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "mysqldump-config":
		path    => "${configuration_dir}/mysqldump.cnf",
		source  => "puppet:///modules/mysql/mysqldump.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
	file { "mysql-isamchk-config":
		path    => "${configuration_dir}/isamchk.cnf",
		source  => "puppet:///modules/mysql/isamchk.cnf",
		notify  => Service["mysql"],
		require => Package["mysql-server"]
	}
}