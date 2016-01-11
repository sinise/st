AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"
AWS::S3::Base.establish_connection!(
  access_key_id: ENV['AMAZON_S3_ACCESS_KEY'],
  secret_access_key: ENV['AMAZON_S3_SECRET_KEY']
)

