class passenger {
package {
	"ruby1.9.3":
		ensure => present,
		alias => "install_ruby"
}
package {
	"build-essential":
		ensure => present,
		alias => "build_essential"
}

package {
	"apache2-prefork-dev":
		ensure => present
}

package { 
	"libaprutil1-dev":
		ensure => present
}

package {
	"libapr1-dev":
		ensure => present
}

package {
	"libcurl4-openssl-dev":
		ensure => present
}
exec {
	"/opt/vagrant_ruby/bin/gem install passenger -v=3.0.11":
		user => root,
		group => root,
		alias => "install_passenger",
		before => [File["passenger_conf"],Exec["passenger_apache_module"]],
		unless => "ls /opt/vagrant_ruby/lib/ruby/gems/1.9.1/gems/passenger-3.0.11"
	}

	exec {
		"/opt/vagrant_ruby/bin/passenger-install-apache2-module --auto":
			user => root,
		group => root,
		path => "/bin:/usr/bin:/usr/local/apache2/bin",
		alias => "passenger_apache_module",
		before => File["passenger_conf"],
		unless => "ls /opt/vagrant_ruby/lib/ruby/gems/1.9.1/gems/\
		passenger-3.0.11/ext/apache2/mod_passenger.so"
	}
	file {
		"/etc/apache2/conf.d/passenger.conf":
		mode => 644,
		owner => root,
		group => root,
		alias => "passenger_conf",
		notify => Service["apache2"],
		source => "puppet:///modules/passenger/passenger.conf"
	}
}
