#
# Cookbook:: aag_infoblox
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'test_infoblox::unit' do
  context 'When all attributes are default, on an Centos' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'checks ip' do
      expect(chef_run).to view_aag_infoblox('check_ip').with(network: '192.168.1.1/24')
    end

    it 'sets ip' do
      expect(chef_run).to set_aag_infoblox('set_ip').with(network: '192.168.1.1/24')
    end

    it 'deletes ip' do
      expect(chef_run).to delete_aag_infoblox('delete_ip').with(network: '192.168.1.1/24')
    end
  end
end
