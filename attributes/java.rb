## java attributes
## This is used with the openjdk version 7 on ubuntu platform.
## Since I did not have a repository that has java
default['java']['jdk_version'] = '8'
# default['java']['install_flavor'] = 'OpenJDK'
# default['java']['jdk']['7']['x86_64']['url'] = 'http://artifactory.example.com/artifacts/jdk-7u65-linux-x64.tar.gz'
# default['java']['jdk']['7']['x86_64']['checksum'] = 'The SHA-256 checksum of the JDK archive'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['accept_license_agreement'] = true