define hosting::webspace($ensure = "present") {
	$path = "${hosting::root_dir}/${name}"
	case $ensure {
		"present": {
			file { "webspace-${name}":
				path => $path,
				ensure => directory,
				group  => "www-data",
				owner  => "www-data",
				mode   => 0770,
			}
		}
		"absent": {
			file { "webspace-${name}":
			path => $path,
			ensure => absent,
			recurse => true,
			purge => true,
			force => true,
		    }
		}
	}
}
