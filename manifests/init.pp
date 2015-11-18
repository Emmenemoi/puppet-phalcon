# = Class: phalcon
#
#
# == Parameters
#
# [*version*]
#   The version of the cphalcon framework to install. Default is master or the
#   latest. The version must match a release tag in the cphalcon repository.
#
#
# Example:
#   phalcon {'install_phalcon':
#     version => 'master',
#   }
#
#   phalcon {'install_phalcon':
#     version => '1.3.1',
#   }
#
#   phalcon {'install_phalcon':
#     version => 'v1.3.1',
#   }
#
#   phalcon {'install_phalcon':
#     version => 'phalcon-1.3.1',
#   }
#
#   phalcon {'install_phalcon':
#     version => 'phalcon-v1.3.1',
#   }
#
# TODO: Remove dependency on puppi::netinstall
#
class phalcon(
  $version = params_lookup('version'),
  $manage_packages = $phalcon::params::manage_packages,
  $http_sapi = $phalcon::params::http_sapi,
  $require_packages = $phalcon::params::require_packages,
) inherits phalcon::params {

  $version_number = $version ? {
    'latest'              => 'master',
    'master'              => 'master',
    /(phalcon-)?(v)?(.*)/ => $3,
    default               => false,
  }

  if ($version_number == false) {
    fail {"Unsupported version '$version', please see notes on specifying version numbers.":}
  }
  elsif ($version_number == 'master') {
    $url = "https://github.com/phalcon/cphalcon/archive/master.tar.gz"
    $extracted_dir = 'cphalcon-master'
  } else {
    $url = "https://github.com/phalcon/cphalcon/archive/phalcon-v$version_number.tar.gz"
    $extracted_dir = "cphalcon-phalcon-v$version_number"
  }

  if $manage_packages {
    ensure_packages( $require_packages , {ensure => 'present', before => Puppi::Netinstall['cphalcon'] })
  }

  puppi::netinstall {'cphalcon':
    url                 => $url,
    destination_dir     => '/var/tmp',
    extracted_dir       => "$extracted_dir",
    postextract_cwd     => "/var/tmp/$extracted_dir/build",
    postextract_command => './install',
    require             => Package[$require_packages],
  }->
  file { "${php_config_dir}/${http_sapi}/conf.d/phalcon.ini":
    ensure  => 'present',
    source  => 'puppet:///modules/phalcon/phalcon.ini',
  }->
  file { "${php_config_dir}/cli/conf.d/phalcon.ini":
    ensure  => 'present',
    source  => 'puppet:///modules/phalcon/phalcon.ini',
  }
}
