class weblabor::site {
	hosting::webspace { "weblabor":
		ensure => present,
	}
	apache2::vhost { "weblabor.hu":
		webspace => "weblabor",
		variant => "weblabor",
		webroot_dir => "root",
		primary_hosts => ["weblabor.hu"],
		redirect_hosts => ["www.weblabor.hu"],
	}
}