#
# Cookbook Name:: aapp
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe "yum-gina"

%w(ksh libgfortran perl perl-XML-LibXML aapp).each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file '/etc/profile.d/aapp_env.sh' do
  source "aapp_env.sh"
  mode 0644
end

user node['aapp']['user']

%w(
  /opt/aapp/AAPP/orbelems
  /opt/aapp/AAPP/orbelems/orb_elem
  /opt/aapp/AAPP/data/calibration/coef
  /opt/aapp/AAPP/data/calibration/coef/amsua
  /opt/aapp/AAPP/data/calibration/coef/amsub
  /opt/aapp/AAPP/data/calibration/coef/avhcl
  /opt/aapp/AAPP/data/calibration/coef/hirs
  /opt/aapp/AAPP/data/calibration/coef/mhs
  /opt/aapp/AAPP/data/calibration/coef/msu
).each do |dir|
  directory dir do
    owner node['aapp']['user']
    group node['aapp']['user']
    recursive true
  end
end
