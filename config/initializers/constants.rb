# frozen_string_literal: true

module CONSTANTS
  THREAD_COUNT = (ENV['RAILS_THREAD_COUNT'] || '4').to_i
end

module RDBMS
  SERIAL_PRIMARY_KEY = 'SERIAL PRIMARY KEY'
  TIMESTAMP_WITH_TIMEZOE = 'timestamp with time zone'
end
