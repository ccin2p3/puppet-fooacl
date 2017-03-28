# Class: fooacl
#
# Main class, to start managing ACLs with the fooacl module.
#
# Sample Usage :
#  include '::fooacl'
#
class fooacl (
  $fooacl_noop      = false,
  $acl_package_name = $::fooacl::params::acl_package_name,
  $fooacl_script_path = $::fooacl::params::fooacl_script_path
) inherits ::fooacl::params {

  if $acl_package_name {
    package { $acl_package_name:
      ensure => 'present',
    }
  }

  $notify = $fooacl_noop ? {
    true  => undef,
    false => Exec[$fooacl_script_path]
  }

  # Main script, to apply ACLs when the configuration changes
  exec { $fooacl_script_path:
    refreshonly => true,
    require     => Package[$acl_package_name],
  }
  concat { $fooacl_script_path:
    mode   => '0755',
    notify => $notify,
  }
  concat::fragment { 'fooacl-header':
    target  => $fooacl_script_path,
    order   => 10,
    content => template("${module_name}/10.erb"),
  }
  concat::fragment { 'fooacl-footer':
    target  => $fooacl_script_path,
    order   => 30,
    content => template("${module_name}/30.erb"),
  }

}
