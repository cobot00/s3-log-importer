# s3-log-importer

Import gzip compressed log file from S3 to PostgreSQL.

## Requirement
* Ruby 2.5.1
* Rails 5.2.0
* PostgreSQL 9.6

## Install
```bash
bundle install
```

## Environment variables
|key|explanation|
|---|---|
|AWS_ACCESS_KEY_ID|AWS credential id|
|AWS_SECRET_ACCESS_KEY|AWS credential secret key|
|AWS_REGION|S3 region|
|AWS_ACCESS_LOG_BUCKET|S3 bucket name|
