# Define: fooacl::conf
#
# Configure the Posix ACLs set by the script from the fooacl class.
#
define fooacl::conf (
  $permissions,
  $target      = $name,
  $order       = 20,
) {

  include '::fooacl'

  concat::fragment { $title:
    target  => $::fooacl::fooacl_script_path,
    order   => $order,
    content => template("${module_name}/20.erb"),
  }

}
