class ResearchToken < ApplicationRecord
  belongs_to :research

  has_secure_token
end
