#
# Cookbook:: .
# Recipe:: master
#
# Copyright:: 2018,  pbtest, All Rights Reserved.
include_recipe 'java'
include_recipe 'jenkins::master'

# Install version 1.3 of the greenballs plugin
# jenkins_plugin 'ssh' do
# end

# jenkins_plugin 'git' do
# end

['ssh', 'git','structs','junit','mailer','git-client','credentials','apache-httpcomponents-client-4-api','ssh-credentials','jsch','scm-api','workflow-scm-step','workflow-step-api','chef', 'chef-cookbook-pipeline'   ].each do |plugin|
  jenkins_plugin "#{plugin}" do
  notifies :restart, 'service[jenkins]', :immediately
   end
end

service 'jenkins' do
    action :nothing
end
