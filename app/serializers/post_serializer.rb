class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :content, :files, :likes
    belongs_to :user
end