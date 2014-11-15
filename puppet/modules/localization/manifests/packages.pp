class localization::packages {
	package { ["language-pack-en", "language-pack-hu"]:
		ensure => latest,
	}
}