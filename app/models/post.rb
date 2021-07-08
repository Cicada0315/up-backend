class Post < ApplicationRecord
    belongs_to :user
    validates :title, :content, :files, presence: true
end
