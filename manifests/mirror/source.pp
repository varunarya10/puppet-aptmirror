## define: apt::mirror::source
## Purpose: create apt mirror repo sources
## Parameters
### mirror_url: source repo url
### release: Release name, default release name is $lsbdistcodename
### components: Space separated list of component names
### include_src: whther to mirror source packages or not
### architecture: which architecture
### clean: whther to clean the specifc repo source to free up the space.

define apt::mirror::source (
  $mirror_url          = 'UNDEF',
  $release           = 'UNDEF',
  $components        = 'main',
  $include_src       = true,
  $architecture      = undef,
  $clean             = true,
) {

  include apt::params
  if $release == 'UNDEF' {
    if $::lsbdistcodename == undef {
      fail('lsbdistcodename fact not available: release parameter required')
    } else {
      $release_real = $::lsbdistcodename
    }
  } else {
    $release_real = $release
  }
  if $mirror_url == 'UNDEF' {
    warning('No Valid mirror mirror_url setup')
  } else {
    concat::fragment { "apt-mirror-${name}.conf":
      target  => '/etc/apt/mirror.list',
      order   => '50',
      content => template('apt/mirror.list-source.erb'),
    }
  }
}
