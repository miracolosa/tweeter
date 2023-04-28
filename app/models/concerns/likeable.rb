module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable

    def liked_by?(user)
      likes.where(User: user).any?
    end
  end
end
