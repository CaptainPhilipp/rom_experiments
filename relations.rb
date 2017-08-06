class Categories < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :taggings
      has_many :tags, through: :taggings, foreign_key: :parent_category_id

      has_many :categories, as: :parent_categories, through: :taggings, foreign_key: :children_category_id
    end
  end
end

class Taggings < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :tag
      belongs_to :category, foreign_key: :parent_category_id

      belongs_to :category, foreign_key: :children_category_id
    end
  end
end

class Tags < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :taggings
      has_many :categories, as: :parent_categories, through: :taggings
      has_many :categories, through: :taggings
    end
  end
end

ROM_CONFIG.register_relation(Tags, Taggings, Categories)
ROM_CONFIG.register_command(CreateTags)
