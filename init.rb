###
# Copyrights (c) 2012 Christopher Dell
# Copyrights (c) 2020 0x2c4
###
require 'redmine_s3'

require_dependency 'redmine_s3_hooks'

Redmine::Plugin.register :redmine_s3 do
  name 's3 connection plugin'
  author '0x2c4 / Piotr Dobrowolski'
  description 'Use Amazon S3 as a storage engine for attachments'
  url 'https://github.com/Informatic/redmine_s3'
  version '0.0.4-hswaw'
end
