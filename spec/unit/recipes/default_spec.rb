#
# Cookbook Name:: aapp
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aapp::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'includes the yum-gina repo' do
      expect(chef_run).to include_recipe('yum-gina')
    end

    it 'installs aapp and dependencies' do
      expect(chef_run).to install_package('ksh')
      expect(chef_run).to install_package('libgfortran')
      expect(chef_run).to install_package('aapp')
    end

    it 'creates aapp_env' do
      expect(chef_run).to create_cookbook_file('/etc/profile.d/aapp_env.sh').with(mode: 0644)
    end

    it 'creates orbelem directories' do
      expect(chef_run).to create_directory("/opt/aapp/AAPP/orbelems").with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory("/opt/aapp/AAPP/orbelems/orb_elem").with(owner: 'processing', group: 'processing')
    end

    it 'gives ownership of calibration coef directories to processing' do
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/amsua').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/amsub').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/avhcl').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/hirs').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/mhs').with(owner: 'processing', group: 'processing')
      expect(chef_run).to create_directory('/opt/aapp/AAPP/data/calibration/coef/msu').with(owner: 'processing', group: 'processing')
    end
  end
end
