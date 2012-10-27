class StorageClient
  attr_accessor :email, :bucket, :client

  def initialize(email, options = {})
    @email  = email
    @client = options[:client] || default_client
  end

  def bucket_name
    @email.gsub(/@/, "-at-").gsub(/\./, "-dot-")
  end

  def bucket
    @bucket ||= (@client.directories.get(bucket_name) ||
                 @client.directories.create(:key => bucket_name))
  end

  def files
    bucket.files
  end

  def file(filename)
    bucket.files.get(filename)
  end

  def create_file(key, body, options = {})
    bucket.files.create(:key => key, :body => body)
  end

  def default_client
    Fog::Storage.new(
      :provider              => 'AWS',
      :aws_access_key_id     => RIAK_CS_ADMIN_KEY,
      :aws_secret_access_key => RIAK_CS_ADMIN_SECRET,
      :host                  => RIAK_CS_HOST,
      :port                  => RIAK_CS_PORT,
      :scheme                => RIAK_CS_SCHEME
    )
  end
  private :default_client
end
