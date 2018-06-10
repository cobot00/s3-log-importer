class CreateAccessLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :access_logs do |t|
      t.column :requested_at, RDBMS::TIMESTAMP_WITH_TIMEZOE, null: false, comment: 'リクエストの受信時刻'
      t.string :uid, limit: 64, null: false, comment: '認証サービスが提供するユーザーID'
      t.string :http_method, limit: 10, null: false, comment: ' GET、POST、DELETE、etc.'
      t.string :path, limit: 100, null: false, comment: 'URLからサーバードメインを除いたもの'
      t.string :summary_key, limit: 100, null: false, comment: 'Railsのcontroller＋@＋action'
      t.string :device_type, limit: 20, null: false, comment: 'pc、smartphone、mobilephone、etc.'
      t.string :os, limit: 20, null: false, comment: 'Windows 10、Mac OSX、etc.'
      t.string :os_version, limit: 20, null: false, comment: 'NT 10.0、etc.'
      t.string :browser, limit: 20, null: false, comment: 'Chrome、HTTP Library、etc.'
      t.string :browser_version, limit: 20, null: false, comment: '67.0.3396.62、curl、etc.'
      t.string :host_name, limit: 250, null: false, comment: 'リクエストを受けたインスタンス名'

      t.column  :created_at, RDBMS::TIMESTAMP_WITH_TIMEZOE, default: -> { 'NOW()' }
      t.column  :updated_at, RDBMS::TIMESTAMP_WITH_TIMEZOE, default: -> { 'NOW()' }
    end

    add_index :access_logs, [:requested_at, :path], name: 'idx_access_logs_01'
  end
end
