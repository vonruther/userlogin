class Comment < ApplicationRecord

  # relationships
  belongs_to :user
  belongs_to :post
end
