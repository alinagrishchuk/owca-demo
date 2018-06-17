name "opsworks-example-role"
description "This role specifies all recipes described in the starter kit guide (README.md)"

run_list(
  "recipe[opsworks-audit]"
  "recipe[my_chef_client]",
  # "recipe[apache2]",
  "recipe[ssh-hardening]"
)
