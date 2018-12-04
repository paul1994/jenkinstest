#
# Cookbook:: jenkinswrapper
# Recipe:: jenkins_misc
#
# Copyright:: 2018, pbradford copyright, All Rights Reserved.
# jenkins_script 'jenkins disable remoting' do
#   command <<-EOH.gsub(/^ {4}/, '')
# import jenkins.model.Jenkins
# jenkins.model.Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)
#   EOH
# end
  
#   jenkins_script 'jenkins disable CSRF Protection' do
#   command <<-EOH.gsub(/^ {4}/, '')
# import hudson.security.csrf.DefaultCrumbIssuer
# import jenkins.model.Jenkins

# if(!Jenkins.instance.isQuietingDown()) {
#     def j = Jenkins.instance
#     if(j.getCrumbIssuer() != null) {
#         j.setCrumbIssuer(null)
#         j.save()
#         println 'CSRF Protection configuration has changed.  Disabled CSRF Protection.'
#     }
#     else {
#         println 'Nothing changed.  CSRF Protection already configured.'
#     }
# }
# else {
#     println "Shutdown mode enabled.  Configure CSRF protection SKIPPED."
# }
#   EOH
# end
