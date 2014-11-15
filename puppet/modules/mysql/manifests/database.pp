define mysql::database($owner, $ensure = 'present') {

	$db_exists   = "${mysql::mysql} -NBe 'SHOW DATABASES' | grep -qFx '${name}'"
	$priv_exists = "${mysql::mysql} -NBe 'SHOW GRANTS FOR \"${owner}\"' | grep \"GRANT ALL PRIVILEGES ON \\`${name}\\`\\.\\* TO.*${owner}\""

	case $ensure {
		default: { 
			err("Unknown ensure value ${ensure}") 
		}
		present: {
			exec { "mysql-create-database-${name}":
				command => "${mysql::mysqladmin} create ${name}",
				unless  => $db_exists
			}
			-> exec { "mysql-grant-${name}-${owner}":
				command => "${mysql::mysql} -NBe \"GRANT ALL ON \`${name}\`.* TO '${owner}'\"",
				require => Mysql::User["${owner}"],
				notify  => Exec["mysql-reload-privileges"],
				unless  => $priv_exists,
			}
		}
		absent: {
			exec { "mysql-drop-database-${name}":
				command => "${mysql::mysqladmin} -f drop ${name}",
				onlyif  => $db_exists
			}
			-> exec { "mysql-revoke-${name}-${owner}":
				command => "${mysql::mysql} -NBe \"REVOKE ALL ON \`${name}\`.* FROM '${owner}'\"",
				require => Mysql::User["${owner}"],
				notify  => Exec["mysql-reload-privileges"],
				onlyif  => $priv_exists,
			}
		}
	}
}