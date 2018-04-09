resource_name :aag_infoblox
property :network, String
property :desiredip, String
property :hostname, Array
property :config_dns, [true, false], default: false
property :username, String
property :password, String
property :infoblox_url, String, required: true
default_action :view

action :view do
  chef_gem 'infoblox' do
    action :install
    compile_time false
  end
  ruby_block 'getip' do
    block do
      require 'infoblox'
      connection = Infoblox::Connection.new(username: new_resource.username, password: new_resource.password, host: new_resource.infoblox_url, ssl_opts: { verify: false })
      networkstuffy = Infoblox::Network.find(connection, network: new_resource.network.to_s).first
      network_base = new_resource.network.match(/\d{1,3}.\d{1,3}.\d{1,3}/)
      array = Array.new(10) { |i| "#{network_base}." + (i + 1).to_s }
      response = networkstuffy.next_available_ip(1, array)
      p response
      Chef::Log.info "Found IP #{response} in Infoblox"
    end
    action :run
  end
end

action :set do
  puts "infoblox::set::entering set action for #{new_resource.network}"
  chef_gem 'infoblox' do
    action :install
    compile_time false
  end
  ruby_block 'setup' do
    block do
      require 'infoblox'
      connection = Infoblox::Connection.new(username: new_resource.username, password: new_resource.password, host: new_resource.infoblox_url, ssl_opts: { verify: false })
      node.run_state['aag_infoblox_ip'] = []
      n = 0
      while n < new_resource.hostname.count
        host = Infoblox::Host.find(connection, 'name' => new_resource.hostname[n].to_s).first
        if host.nil?
          networkstuffy = Infoblox::Network.find(connection, network: new_resource.network.to_s).first
          # getting first 3 octets of the ip address
          network_base = new_resource.network.match(/\d{1,3}.\d{1,3}.\d{1,3}/)
          # excluding first ten ip addresses reserved
          array = Array.new(10) { |i| "#{network_base}." + (i + 1).to_s }
          # add ip to array
          ip = networkstuffy.next_available_ip(1, array).first
          # reserve ip
          hostbuilder = Infoblox::Host.new(connection: connection)
          hostbuilder.name = new_resource.hostname[n]
          hostbuilder.ipv4addrs = [ipv4addr: ip]
          hostbuilder.configure_for_dns = new_resource.config_dns
          hostbuilder.post
          Chef::Log.info "Wrote #{new_resource.hostname[n]} with IP #{ip} in infoblox"
          node.run_state['aag_infoblox_ip'] << { new_resource.hostname[n] => ip }
          puts "infoblox::set::reserved #{ip}"
        else
          node.run_state['aag_infoblox_ip'] << { new_resource.hostname[n] => host.ipv4addrs[0].ipv4addr }
          puts "infoblox::set::reusing #{host.ipv4addrs[0].ipv4addr}"
        end
        n += 1
      end
    end
    action :run
  end
end

action :delete do
  chef_gem 'infoblox' do
    action :install
    compile_time false
  end
  ruby_block 'delete' do
    block do
      require 'infoblox'
      connection = Infoblox::Connection.new(username: username, password: password, host: infoblox_url, ssl_opts: { verify: false })
      host = Infoblox::Host.find(connection, 'name' => hostname).first
      if host.nil?
        Chef::Log.info "Cannot find #{hostname}"
      else
        node.run_state['aag_infoblox_ip'] = host.ipv4addrs[0].ipv4addr
        host.delete
        Chef::Log.info "Deleted #{hostname} in infoblox"
      end
    end
    action :run
  end
end
