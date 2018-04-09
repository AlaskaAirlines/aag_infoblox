name 'aag_infoblox'
maintainer 'Christopher Maher'
maintainer_email 'chris@mahercode.io'
license 'Apache-2.0'
description 'Custom Resource for Infoblox'
long_description 'This Custom Resource lets you interact with Infoblox to view, set, and delete IP reservations'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

%w(amazon centos fedora oracle redhat scientific zlinux windows ubuntu).each do |os|
  supports os
end

issues_url 'https://github.com/alaskaairlines/aag_infoblox/issues'
source_url 'https://github.com/alaskaairlines/aag_infoblox'
