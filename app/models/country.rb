class Country < ApplicationRecord
  self.primary_key = 'country_code'

  def readonly?
    # true
  end
end
