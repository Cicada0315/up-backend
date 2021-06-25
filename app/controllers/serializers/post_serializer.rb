class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :content, :files
    belongs_to :user
end