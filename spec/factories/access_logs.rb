FactoryBot.define do
  factory :access_log do
    uid do
      SecureRandom.uuid
    end
    http_method 'GET'
    path '/user'
    summary_key 'user@show'
    device_type 'pc'
    os 'Windows 10'
    os_version 'NT 10.0'
    browser 'Chrome'
    browser_version '67.0.3396.62'
    host_name 'server01'
  end
end
