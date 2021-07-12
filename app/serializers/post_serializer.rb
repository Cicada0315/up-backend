class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :content, :files, :view, :likes, :created_at
    belongs_to :user
end