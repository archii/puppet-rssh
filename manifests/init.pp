# Installs and configures rssh.
class rssh(
  $package     = 'rssh',
  $custom_package = false,
  $custom_package_provider = undef,
  $custom_package_source = undef,
  $config_file = '/etc/rssh.conf',
  $config_mode = '0644',
  $allow       = [],
  $umask       = '022',
  $logfacility = 'LOG_USER',
  $chrootpath  = false,
  $users       = []
) {
  if $custom_package {
    package { $package:
      ensure   => present,
      provider => $custom_package_provider,
      source   => $custom_package_source,
      before   => File[$config_file],
    }
  } else {
    package { $package:
      ensure => present,
      before => File[$config_file],
    }
  }

  file { $config_file:
    ensure  => present,
    mode    => $config_mode,
    content => template('rssh/rssh.conf.erb'),
  }
}
