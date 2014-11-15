class crond {
	package { "cron":
		ensure => latest,
	}
	service { "cron":
		ensure => running,
	}
}