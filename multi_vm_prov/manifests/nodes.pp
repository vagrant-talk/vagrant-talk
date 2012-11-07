Exec {
        path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}
node "app" {
	include apache2
	include passenger
}

node "db" {
	include mysql
}
node "static" {
	include apache2
}
