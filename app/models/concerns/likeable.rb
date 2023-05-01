module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable

    def liked_by?(user)
      likes.where(user_id: user).any?
    end
  end
end
