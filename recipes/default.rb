#
# Cookbook Name:: aapp
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

%w(ksh libgfortran perl perl-XML-LibXML).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/aapp-7.10-1.x86_64.rpm" do 
  source "https://s3-us-west-2.amazonaws.com/gina-packages/aapp-7.10-1.x86_64.rpm"
end

rpm_package "#{Chef::Config[:file_cache_path]}/aapp-7.10-1.x86_64.rpm"


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

# Fix the hard-codes space-track tle source
replace_or_add "space-track-tle" do
  path "/opt/aapp/ATOVS_ENV7"
  pattern "^PAR_NAVIGATION_TLE_URL_DOWNLOAD='https://www.space-track.org'"
  line "# PAR_NAVIGATION_TLE_URL_DOWNLOAD='https://www.space-track.org'"
end

replace_or_add "celestrack-tle" do
  path "/opt/aapp/ATOVS_ENV7"
  pattern "^#PAR_NAVIGATION_TLE_URL_DOWNLOAD='http://ftp.celestrak.com/NORAD/elements/weather.txt'"
  line "PAR_NAVIGATION_TLE_URL_DOWNLOAD='http://ftp.celestrak.com/NORAD/elements/weather.txt'"
end
