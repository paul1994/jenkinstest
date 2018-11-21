#
# Cookbook:: .
# Recipe:: master
#
# Copyright:: 2018,  pbtest, All Rights Reserved.
# Note this is aWIP and has scrap and other mess I need to clean up

include_recipe 'java'
include_recipe 'jenkins::master'

# Install version 1.3 of the greenballs plugin
# jenkins_plugin 'ssh' do
# end

# You will probably want to add some users so you can login!

# Turn on basic authentication
# jenkins_script 'setup authentication' do
#   command <<-EOH.gsub(/^ {4}/, '')
#     import jenkins.model.*
#     def instance = Jenkins.getInstance()

#     import hudson.security.*
#     def realm = new HudsonPrivateSecurityRealm(false)
#     instance.setSecurityRealm(realm)

#     def strategy = new #{node['jenkins']['AuthorizationStrategy']}()
#     instance.setAuthorizationStrategy(strategy)

#     instance.save()
#   EOH
# end

# Create a Jenkins user with specific attributes
jenkins_user 'grumpy' do
  full_name  'Grumpy Dwarf'
  email      'grumpy@example.com'
  password   'password11'
end

jenkins_user 'panther' do
  full_name    'Panther user'
  email        'panther@example.com'
  password   'password11'
end

jenkins_user 'chef' do
  id "chef@#{Chef::Config[:node_name]}"
  full_name "Chef"
end

ruby_block 'load jenkins credential' do
  block do
    require 'openssl'
    require 'net/ssh'

    key = ::OpenSSL::PKey::RSA.new ::File.read Chef::Config[:client_key]

    node.run_state[:jenkins_private_key] = key.to_pem

    jenkins = resources('jenkins_user[chef]')
    jenkins.public_keys ["#{key.ssh_type} #{[key.to_blob].pack('m0')}"]
  end
end

# working auth but broken at the moment 
jenkins_script 'jenkins auth' do
  command <<-EOH.gsub(/^ {4}/, '')
import jenkins.model.Jenkins
def instance = Jenkins.getInstance()

import hudson.security.*

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(hudsonRealm)

permissions = new hudson.security.GlobalMatrixAuthorizationStrategy()
permissions.add(Jenkins.ADMINISTER, 'panther')
permissions.add(Jenkins.ADMINISTER, '#{resources('jenkins_user[chef]').id}')
permissions.add(hudson.model.View.READ, 'anonymous')
permissions.add(hudson.model.Item.READ, 'anonymous')
permissions.add(Jenkins.READ, 'anonymous')

Jenkins.instance.authorizationStrategy = permissions

Jenkins.instance.save()
  EOH
end

# # Add initial user
# jenkins_script 'add user2' do
#   command <<-EOH.gsub(/^ {4}/, '')
# import jenkins.model.*
# import hudson.security.*

# def instance = Jenkins.getInstance()

# def hudsonRealm = new HudsonPrivateSecurityRealm(false)
# hudsonRealm.createAccount("panther2","password11")
# instance.setSecurityRealm(hudsonRealm)
# instance.save()
#   EOH
# end


# # Add admin user
# jenkins_script 'add admin user' do
#   command <<-EOH.gsub(/^ {4}/, '')
#     import jenkins.model.*
#     def instance = Jenkins.getInstance()

#     import hudson.security.*

#     def strategy = new hudson.security.GlobalMatrixAuthorizationStrategy()
#     strategy.add(Jenkins.ADMINISTER, 'authenticated')
#     instance.setAuthorizationStrategy(strategy)

#     instance.save()
#       EOH
# end


# echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("user1", "password123")' |
# java -jar jenkins-cli.jar -s http://localhost/ groovy =
