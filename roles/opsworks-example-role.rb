name "opsworks-example-role"
description "This role specifies all recipes described in the starter kit guide (README.md)"

run_list(
  "recipe[my_chef_client]",
  "recipe[my_audit]"
)
