# Chef Infoblox Resource

[[![Build Status](https://travis-ci.org/alaskaairlines/aag_infoblox.svg?branch=master)](https://travis-ci.org/alaskaairlines/aag_infoblox) ![Resource Version](https://img.shields.io/badge/Resource-0.1.0-blue.svg)](https://supermarket.chef.io/cookbooks/chef_fedora_base) [![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://choosealicense.com/licenses/apache-2.0)

This is a Chef Custom Resource that makes interacting with Infoblox easy. There are three actions: view, set, and
delete. 

## Scope

This resource utilized the infoblox community RubyGem. Right now the resource can perform three actions. More are
aviable via the gem and can be added if needed.

## Requirements

- Chef 13 or later
- Network access to Infoblox and internect access to download gem

## Platform Support

Tested on:
- Fedora 27
- CentOS 7.4
- Ubuntu 16.04
- Windows 2008R2/2012R2

## Resource Dependencies

This resource depends on the infoblox community gem. 

## Contributing

Please submit pull requests with fixes or ideas for improvement. FOSS is all about collaboration, so please join in!

## Maintainers

- Christopher Maher ([chris@mahercode.io](mailto:chris@mahercode.io))
- Garin Kartes ([gkartes@gmail.com](mailto:gkartes@gmail.com))

## License
```text 
Copyright:: 2018 Alaska Airlines, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
