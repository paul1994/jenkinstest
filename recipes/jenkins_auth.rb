#
# Cookbook:: jenkinswrapper
# Recipe:: jenkins_auth
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Working Auth but has Anonymous having admin rights need to reconfigure
# so that anon is not used? what is used during the install
jenkins_script 'jenkins auth' do
  command <<-EOH.gsub(/^ {4}/, '')
import jenkins.model.Jenkins
def instance = Jenkins.getInstance()

import hudson.security.*

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(hudsonRealm)

permissions = new hudson.security.GlobalMatrixAuthorizationStrategy()
permissions.add(Jenkins.ADMINISTER, 'anonymous')
permissions.add(Jenkins.ADMINISTER, 'panther')
permissions.add(Jenkins.ADMINISTER, '#{resources('jenkins_user[chef]').id}')
permissions.add(hudson.model.View.READ, 'anonymous')
permissions.add(hudson.model.Item.READ, 'anonymous')
permissions.add(Jenkins.READ, 'anonymous')

Jenkins.instance.authorizationStrategy = permissions

Jenkins.instance.save()
  EOH
end

