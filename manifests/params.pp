#
#
class phalcon::params {
  $version = 'master'

  $manage_packages = true

  $php_config_dir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint|SLES|OpenSuSE)/ => '/etc/php5',
    default                                 => '/etc/php.d',
  }

  $require_packages = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => ['php5', 'php5-dev', 'libpcre3-dev'],
    /(?i:SLES|OpenSuSe)/      => ['php5','php5-devel', 'pcre-devel'],
    default                   => ['php', 'php-devel', 'pcre-devel'],
  }

  $http_sapi = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint|SLES|OpenSuSE)/ => 'apache2',
    default                                 => '',
  }

  if $::php_version == '' or versioncmp($::php_version, '5.4') >= 0 {
    $mods_root_ini = "${php_config_dir}/mods-available"
  } else {
    $mods_root_ini = "${php_config_dir}/conf.d"
  }

}
