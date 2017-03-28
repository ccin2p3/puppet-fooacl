# Class: fooacl::params
#
# Per-platform parameters for fooacl class
#
class fooacl::params {

  $fooacl_script_path = '/usr/local/sbin/fooacl'

  case $::osfamily {
    'gentoo': {
      $acl_package_name = 'sys-apps/acl'
    }
    default: {
      $acl_package_name = 'acl'
    }
  }
}
