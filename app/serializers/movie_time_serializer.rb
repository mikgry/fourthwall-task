class MovieTimeSerializer < ActiveModel::Serializer
  attributes :id, :show_at

  belongs_to :movie
end
