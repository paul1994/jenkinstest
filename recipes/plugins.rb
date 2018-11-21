#
# Cookbook:: jenkinswrapper
# Recipe:: plugins
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Flag set to true if plugin is installed or updated and jenkins will be restarted.
restart_required = false

# jenkins_plugins in a ruby for each loop 'git' do
jenkins_plugins = %w(
  ssh
  credentials
  greenballs
  pam-auth
  matrix-auth
)
# chef-cookbook-pipeline 
# blueocean
#  ssh-credentials
#  ssh-slaves
#  script-security
#  git
#  structs
#  junit
#  mailer
#  git-client
# github-oauth

jenkins_plugins.each do |plugin|
  plugin, version = plugin.split('=')
  jenkins_plugin plugin do
    version version if version
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately
   end
end


# Is notified only when a 'jenkins_plugin' is installed or updated.
ruby_block "jenkins_restart_flag" do
  block do
    restart_required = true
  end
  action :nothing
end

# Using the jenkins cookbook restart after plugin install
jenkins_command 'safe-restart' do
    only_if { restart_required }
end

jenkins_script 'get list of latest plugins' do
  command <<-eos.gsub(/^\s+/, '')
    pm = jenkins.model.instance.pluginManager
    pm.doCheckUpdatesServer()
  eos

  not_if do
    update_frequency = 86_400 # daily
    update_file = '/var/lib/jenkins/updates/default.json'
    ::File.exists?(update_file) &&
      ::File.mtime(update_file) > Time.now - update_frequency
  end
end
