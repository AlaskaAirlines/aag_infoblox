# All of these resources use stubbed data. Bozo the Clown is friendly and can be substituted with anything else

aag_infoblox 'check_ip' do
  network '192.168.1.1/24'
  action :view
  username 'bozo'
  password 'theclown'
  infoblox_url 'https://infoblox.mydomain.net'
end

aag_infoblox 'set_ip' do
  hostname ['system1.mydomain.net', 'system2.mydomain.net']
  username 'bozo'
  password 'theclown'
  infoblox_url 'https://infoblox.mydomain.net'
  network '192.168.1.1/24'
  config_dns true
  action :set
end

aag_infoblox 'delete_ip' do
  hostname ['system1.mydomain.net', 'system2.mydomain.net']
  username 'bozo'
  password 'theclown'
  infoblox_url 'https://infoblox.mydomain.net'
  network '192.168.1.1/24'
  config_dns true
  action :delete
end
