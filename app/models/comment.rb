class Comment < ApplicationRecord
  belongs_to :manual
  belongs_to :user
end
