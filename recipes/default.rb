#
# Cookbook Name:: riaksearch
# Recipe:: default
#
# Copyright 2011, Saaspire LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe('java::sun')
include_recipe('riaksearch::erlang')

if node.kernel.machine == 'x86_64'
    package_url = 'http://downloads.basho.com/riak-search/riak-search-0.14/riak-search_0.14.2-1_amd64.deb'
    package_checksum = 'cc7877c364210ff9c43211a2544d3a9385187cb52b0fecd7460481da72d4cba6'
else
    package_url = 'http://downloads.basho.com/riak-search/riak-search-0.14/riak-search_0.14.2-1_i386.deb'
    package_checksum = 'ccc75791684b411104e0b1d18bb06ae0c54d6c9b252be8252f451222282a5b79'
end

package_file = package_url.split('/').last
package_name = package_file.split("[-_]\d+\.").first

remote_file "/usr/src/#{package_file}" do
    source package_url
    owner "root"
    mode 0644
    checksum package_checksum
end

package package_name do
    source "/usr/src/#{package_file}"
    action :install
    provider Chef::Provider::Package::Dpkg
end

service "riaksearch" do
    supports :start => true, :stop => true, :restart => true
    action [ :enable ]
    #subscribes :restart, resources(:template => [ "#{node[:riak][:package][:config_dir]}/app.config",
    #                                              "#{node[:riak][:package][:config_dir]}/vm.args" ])
end
