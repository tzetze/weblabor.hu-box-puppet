define mysql::user($password = '', $ensure = 'present') {

	$user_exists = "${mysql::mysql} -NBe \"SELECT user FROM mysql.user WHERE host = '%'\" | grep -qFx ${name}"
	$user_exists_with_diff_pw = "${mysql::mysql} -NBe \"SELECT user FROM mysql.user WHERE host = '%' AND password != '${password}'\" | grep -qFx ${name}"

	case $ensure {
		default: { 
			err("Unknown ensure value ${ensure}") 
		}
		present: {
			exec { "create-mysql-user-${name}":
				command => "${mysql::mysql} -NBe \"INSERT INTO mysql.user SET host='%', user = '${name}', password = '${password}'\"",
				unless  => $user_exists,
				notify  => Exec["mysql-reload-privileges"],
			}
			exec { "update-mysql-user-${name}":
				command => "${mysql::mysql} -NBe \"UPDATE mysql.user SET password = '${password}' WHERE host='%' AND user = '${name}'\"",
				onlyif  => $user_exists_with_diff_pw,
				notify  => Exec["mysql-reload-privileges"],
			}
		}
		absent: { 
			exec { "drop-mysql-user-${name}":
				command => "${mysql::mysql} -NBe \"DELETE FROM mysql.user WHERE host='%' AND user='${name}'\"",
				onlyif  => $user_exists,
				notify  => Exec["mysql-reload-privileges"],
			}
		}
	}
}