class Post < ApplicationRecord
    belongs_to :user
    validates :title, :content, :files, presence: true

    scope :search, -> (query) {where("title LIKE ?", "%#{query}%")}
    scope :ups, -> {order created_at: :desc}
end
