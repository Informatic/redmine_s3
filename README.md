# S3 plugin for Redmine

## Description
This plugin for Redmine allows to store all file in s3 (Wasabi, Amazon etc.). This is a fork for [original gem](http://github.com/tigrish/redmine_s3).
This plugin has been adjusted and now is compatible with Redmine 4.1.1

## Installation
1. Go to the Redmine root and then to the plugin folder
2. `git clone git://github.com/0x2c4/redmine_s3_wasabi.git`
3. Inside the Plugin directory run: `cp redmine_s3_wasabi/config/s3.yml.example ../config/s3.yml`
4. Edit config/s3.yml Add endpoint for your s3 and all other settings (see s3 Options Details)
5. `bundle install`
6. Restart your Ruby webserver or the machine

## s3 Options Details
* access_key_id: string key (required)
* secret_access_key: string key (required)
* bucket: string bucket name (required)
* folder: string folder name inside bucket (for example: 'attachments')
* endpoint: string endpoint instead of s3.amazonaws.com
* port: integer port number
* ssl: boolean true/false
* secure: boolean true/false
* private: boolean true/false
* expires: integer number of seconds for private links to expire after being generated
* proxy: boolean true/false
* thumb_folder: string folder where attachment thumbnails are stored; defaults to 'tmp'
* Defaults to private: false, secure: false, proxy: false, default endpoint, default port, default ssl and default expires


## License
Copyrights (c) 2012 Christopher Dell
Copyrights (c) 2020 0x2c4
This plugin is released under the [MIT License](http://www.opensource.org/licenses/MIT).
