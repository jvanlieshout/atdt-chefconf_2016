resource_name :pip

property :package_name, String, name_property: true

action :install do
  execute "/usr/local/bin/pip3 install #{package_name}" 
end