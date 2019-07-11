class DynamoDBLockClientOption
  attr_accessor :dynamo_db, :table_name, :ttl
  def initialize
    @ttl = 1000
  end
end

class DynamoDBLockClient
  class DynamoDBLockException < StandardError; end

  def initialize(opts)
    @opts = opts
  end

  def acquire_lock(key)
    @opts.dynamo_db.put_item(
      item: { 'Key' => key, 'ttl' => Time.now.to_i + @opts.ttl },
      table_name: @opts.table_name,
      condition_expression: 'attribute_not_exists(#k)',
      expression_attribute_names: {
        '#k': 'Key'
      }
    )
  rescue Aws::DynamoDB::Errors::ConditionalCheckFailedException => _e
    raise DynamoDBLockException
  end
end
