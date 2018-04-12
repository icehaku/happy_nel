class Research < ApplicationRecord
  has_many :token

  def get_result
    "777"
  end

  def finish
    self.update_attributes(concluded: true)
  end
end
