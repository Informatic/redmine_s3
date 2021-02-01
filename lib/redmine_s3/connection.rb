require 'aws-sdk-s3'

module RedmineS3
  class Connection
    @@conn = nil
    @@s3_options = {
      :access_key_id     => nil,
      :secret_access_key => nil,
      :bucket            => nil,
      :folder            => '',
      :endpoint          => nil,
      :port              => nil,
      :ssl               => nil,
      :private           => false,
      :expires           => nil,
      :secure            => false,
      :proxy             => false,
      :thumb_folder      => 'tmp',
      :region            => 'test',
      :force_path_style  => true,
    }

    class << self
      def load_options
        @@s3_options.each_key { |key|
          env_key = "REDMINE_S3_#{key.upcase}"
          if ENV.has_key?(env_key) then
            if @@s3_options[key].in? [true, false] then
              @@s3_options[key] = ENV.fetch(env_key).in? ['true', '1']
            else
              @@s3_options[key] = ENV.fetch(env_key)
            end
          end
        }
      end

      def establish_connection
        load_options unless @@s3_options[:access_key_id] && @@s3_options[:secret_access_key]
        options = {
          :region => @@s3_options[:region],
          :access_key_id => @@s3_options[:access_key_id],
          :secret_access_key => @@s3_options[:secret_access_key],
          :force_path_style => @@s3_options[:force_path_style],
        }
        options[:endpoint] = self.endpoint unless self.endpoint.nil?
        @conn = client = Aws::S3::Resource.new(options)
      end

      def conn
        @@conn || establish_connection
      end

      def bucket
        load_options unless @@s3_options[:bucket]
        @@s3_options[:bucket]
      end

      def create_bucket
        bucket = self.conn.bucket(self.bucket)
        bucket.create unless bucket.exists?
      end

      def folder
        str = @@s3_options[:folder]
        if str.present?
          str.match(/\S+\//) ? str : "#{str}/"
        else
          ''
        end
      end

      def endpoint
        @@s3_options[:endpoint]
      end

      def port
        @@s3_options[:port]
      end

      def ssl
        @@s3_options[:ssl]
      end

      def expires
        @@s3_options[:expires]
      end

      def private?
        @@s3_options[:private]
      end

      def secure?
        @@s3_options[:secure]
      end

      def proxy?
        @@s3_options[:proxy]
      end

      def thumb_folder
        str = @@s3_options[:thumb_folder]
        if str.present?
          str.match(/\S+\//) ? str : "#{str}/"
        else
          'tmp/'
        end
      end

      def object(filename, target_folder = self.folder)
        bucket = self.conn.bucket(self.bucket)
        bucket.object(target_folder + filename)
      end

      def put(disk_filename, original_filename, data, content_type='application/octet-stream', target_folder = self.folder)
        object = self.object(disk_filename, target_folder)
        options = {}
        options[:body] = data
        options[:acl] = "public-read" unless self.private?
        options[:content_type] = content_type if content_type
        options[:content_disposition] = "inline; filename=#{ERB::Util.url_encode(original_filename)}"
        object.put(options)
      end

      def delete(filename, target_folder = self.folder)
        object = self.object(filename, target_folder)
        object.delete
      end

      def object_url(filename, target_folder = self.folder)
        object = self.object(filename, target_folder)
        if self.private?
          options = {:secure => self.secure?}
          options[:expires] = self.expires unless self.expires.nil?
          object.presigned_url(:get, options).to_s
        else
          object.public_url(:secure => self.secure?).to_s
        end
      end

      def get(filename, target_folder = self.folder)
        object = self.object(filename, target_folder)
        object.get().body
      end
    end
  end
end
