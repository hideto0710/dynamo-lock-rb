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
    resp = @opts.dynamo_db.get_item(
      key: { 'Key' => key },
      table_name: @opts.table_name
    )
    raise DynamoDBLockException unless resp.item.nil?

    @opts.dynamo_db.put_item(
      item: { 'Key' => key, 'ttl' => Time.now.to_i + @opts.ttl },
      table_name: @opts.table_name
    )
  end
end
