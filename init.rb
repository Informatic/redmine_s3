###
# Copyrights (c) 2012 Christopher Dell
# Copyrights (c) 2020 0x2c4
###
require 'redmine_s3-Wasabi'

require_dependency 'redmine_s3_hooks'

Redmine::Plugin.register :redmine_s3 do
  name 's3 connection plugin'
  author '0x2c4'
  description 'Use Amazon S3 as a storage engine for attachments'
  url 'https://github.com/0x2c4/redmine_s3'
  version '0.0.4'
end
