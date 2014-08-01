## Class: apt::mirror
## Purpose: Configure apt-mirror
## Parameters
### base_path, mirror_path, skel_path, var_path: set different directory locations
### mirror_path: set mirror path
### cleanscript: cleanscript path
### postmirror_script: path to postmirror script
### defaultarch: default architecture
### run_postmirror: whether to run postmirror or not
### nthreads: number of threads for mirroring
### tilde:

class apt::mirror(
    $base_path         = '/var/spool/apt-mirror',
    $mirror_path       = '$base_path/mirror',
    $skel_path         = '$base_path/skel',
    $var_path          = '$base_path/var',
    $cleanscript       = '$base_path/clean.sh',
    $postmirror_script = '$var_path/postmirror.sh',
    $defaultarch       = 'amd64',
    $run_postmirror    = '0',
    $nthreads          = '20',
    $_tilde            = '0',
  ) {

  ## Install apt-mirror package
  package { 'apt-mirror':
    ensure => present,
  }

  ## Add base configuration in mirror.list

  concat { '/etc/apt/mirror.list':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['apt-mirror'],
  }

  concat::fragment { "apt-mirror-${name}.conf":
    target  => '/etc/apt/mirror.list',
    order   => '1',
    content => template('apt/mirror.list-base.erb'),
  }
}

