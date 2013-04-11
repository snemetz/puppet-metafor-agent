# = Class metafor::params
#
# Setup default parameters
#
class metafor::params {
  case $::osfamily {
    'Debian': {
      $packages = ['findutils','debsums']
    } 
    'RedHat': {
      $packages = ['findutils']
    }
    default : {
      fail { "ERROR: Metafor unsupported on OS: ${::osfamily}": }
    }
  }
  $metafor_guid = ''
  $metafor_password = ''
}
