# Raises the open file limit for nginx so it can handle high concurrency
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
}

# Restarts nginx to apply the new limit
exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
  require => Exec['fix--for-nginx'],
}
