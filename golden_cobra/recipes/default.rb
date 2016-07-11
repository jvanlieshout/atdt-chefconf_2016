#
# Cookbook Name:: golden_cobra
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'yum update -y'

package 'sqlite-devel'

include_recipe 'python'

%w(django uwsgi gunicorn).each { |package| pip package }

directory '/sites'

package 'git'

search('site', '*:*').each do |site_data|
  site_name = site_data[:name]
  site_repository = site_data[:repository]
  site_bind = site_data[:bind]

  git "/sites/#{site_name}" do
    repository site_repository
    revision 'master'
    action :sync
  end

  execute '/usr/local/bin/python3 manage.py migrate' do
    cwd "/sites/#{site_name}"
  end

  execute "gunicorn #{site_name}.wsgi -D -b #{site_bind}" do
    cwd "/sites/#{site_name}"
  end
end
