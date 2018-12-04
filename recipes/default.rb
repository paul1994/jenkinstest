#
# Cookbook:: jenkinswrapper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'jenkinswrapper::master'
include_recipe 'jenkinswrapper::plugins'
include_recipe 'jenkinswrapper::jenkins_auth'
include_recipe 'jenkinswrapper::jenkins_misc'
