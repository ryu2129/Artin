class Artist < ApplicationRecord
  attachment :image
  belongs_to :user
end
