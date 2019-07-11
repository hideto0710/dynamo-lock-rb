# dynamo-lock-rb

## setup
```bash
bundle install --path vendor/bundle
bundle exec ruby main.rb
```

```bash
aws dynamodb --endpoint http://localhost:8000 list-tables
aws dynamodb --endpoint http://localhost:8000 create-table \
    --cli-input-json file://schema.json
aws dynamodb --endpoint http://localhost:8000 describe-time-to-live \
    --table-name JobLock
aws dynamodb --endpoint http://localhost:8000 update-time-to-live \
    --table-name JobLock --time-to-live-specification "Enabled=true, AttributeName=ttl"
```

```bash
bundle exec ruby main.rb example
bundle exec ruby main.rb example
# => DynamoDBLockClient::DynamoDBLockException
```
