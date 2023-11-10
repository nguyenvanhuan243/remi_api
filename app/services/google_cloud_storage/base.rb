require 'google/cloud/storage'
module GoogleCloudStorage
  class Base
    attr_reader :instant
    attr_reader :column_name
    attr_reader :storage
    attr_reader :bucket_name
    attr_reader :json_key_path

    def initialize(instant = nil, column_name = nil)
      @instant       = instant
      @column_name   = column_name
      @bucket_name   = ENV['FOG_DIRECTORY']
      @json_key_path = Rails.root.join(ENV.fetch('GOOGLE_JSON_KEY_LOCATION', 'config/fog.json'))
      @storage       = Google::Cloud::Storage.new(project_id: ENV['GOOGLE_PROJECT'], credentials: json_key_path)
    end

    def upload(image_file)
      raise ErrorsHandler::NotAllowed, I18n.t('errors.messages.invalid_mime_type') unless valid_image?(image_file)

      handle_upload(image_file)
    end

    private

    def valid_image?(image_file)
      return false unless image_file.is_a?(ActionDispatch::Http::UploadedFile)
      return false unless allowed_content_types.include?(image_file.content_type)

      true
    end

    def allowed_content_types
      ['image/jpeg', 'image/png', 'image/gif']
    end

    def handle_upload(image_file)
      bucket           = storage.bucket(bucket_name)
      file_path        = "#{store_dir}/#{filename(image_file)}"
      bucket.create_file(image_file.tempfile.path, file_path, acl: 'public')
      bucket.file(file_path).public_url
    end

    def store_dir
      "#{column_name}/#{get_tenant}/#{get_model_name}/#{instant.id}"
    end

    def filename(image_file)
      "#{Time.now.to_i}_#{image_file.original_filename.gsub(/\s+/, '_')}"
    end

    def get_tenant
      instant.is_a?(TradingAccountView) ? instant.tenant : Apartment::Tenant.current
    end

    def get_model_name
      model_name = instant.class.to_s
      model_name = TradingAccount.to_s if model_name == TradingAccountView.to_s
      model_name.underscore
    end
  end
end
