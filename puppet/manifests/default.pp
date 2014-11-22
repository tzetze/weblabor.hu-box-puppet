stage { [pre, post]: }
Stage[pre] -> Stage[main] -> Stage[post]

class { 'apt-update::update': stage => pre }

include apache2
include php5
include mysql
include crond
include subversion
include trac
include localization
include tools
include hosting
include weblabor
