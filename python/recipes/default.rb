#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if platform?('ubuntu')
  package %w[build-essential]
else
  package %w[openssl-devel]
end

# remote_file '/tmp/Python-3.4.4.tgz' do
  # source 'https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz'

  # notifies :run, 'execute[extract python]', :immediately
# end

# execute 'extract python' do
  # command 'tar xzf /tmp/Python-3.4.4.tgz'
  # cwd '/tmp'
  # action :nothing
  # notifies :run, 'execute[python build and install]', :immediately
# end

# execute 'python build and install' do
  # command './configure && make install'
  # cwd '/tmp/Python-3.4.4'
  # action :nothing
# end

ark 'python' do
  url 'https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz'
  version '3.4.4'
  checksum 'bc93e944025816ec360712b4c42d8d5f729eaed2b26585e9bc8844f93f0c382e'
  # make_opts ['TARGET=linux26']
  action :install_with_make
end
