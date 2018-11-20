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
jenkins_plugins = %w(
  ssh
  git
  structs
  junit
  mailer
  git-client
  credentials
)
jenkins_plugins.each do |plugin|
  jenkins_plugin "#{plugin}" do
#   notifies :restart, 'service[jenkins]', :delayed
   end
end
# plugins taken out of the loop above
#,'chef-cookbook-pipeline'

jenkins_command 'safe-restart' do
    action :execute
end
