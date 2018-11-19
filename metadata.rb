name 'jenkinswrapper'
maintainer 'Paul Bradford'
maintainer_email 'pbradford@chef.io'
license 'Apache-2.0'
description 'Installs/Configures jenkinswrapper'
long_description 'Installs/Configures This is a jenkins wrapper cookbook'
version '0.1.0'
chef_version '>= 13.0'
supports 'ubuntu'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
 issues_url 'https://github.com/paul1994/jenkinswrapper/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/paul1994/jenkinswrapper'

depends 'jenkins', '= 6.2.1'
depends 'java', '= 3.1.1'