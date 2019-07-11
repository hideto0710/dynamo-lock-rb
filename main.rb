# frozen_string_literal: true

require 'aws-sdk'
require './dynamo_db_lock_client'

dynamodb = Aws::DynamoDB::Client.new(
  endpoint: 'http://localhost:8000'
)

client_options = DynamoDBLockClientOption.new
client_options.dynamo_db = dynamodb
client_options.table_name = 'JobLock'

client = DynamoDBLockClient.new(client_options)
client.acquire_lock(ARGV[0])
