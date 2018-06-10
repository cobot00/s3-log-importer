class AccessLog < ApplicationRecord
  class << self
    def delete_by_date(date)
      where(requested_at: date.beginning_of_day...date.end_of_day).delete_all
    end
  end
end
