class localization::timezone {
	file { "/etc/timezone":
		content => "Europe/Budapest\n",
		owner => root,
		group => root,
		mode => 0644,
		notify => Exec["tzdata_reconfigure"],
	}
	-> exec { "tzdata_reconfigure":
		command => "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata",
		refreshonly => true,
	}
}