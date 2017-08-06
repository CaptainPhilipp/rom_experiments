class Categories < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :parameters, through: :children_parents, foreign_key: :parent_category_id

      has_many :categories, as: :parent_categories, through: :children_parents, foreign_key: :children_category_id
    end
  end
end

class ChildrenParents < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :parameter, foreign_key: :children_parameter_id
      belongs_to :category, foreign_key: :parent_category_id

      belongs_to :category, foreign_key: :children_category_id
    end
  end
end

class Parameters < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :categories, as: :parent_categories, through: :children_parents, foreign_key: :children_parameter_id
      has_many :categories, through: :children_parents, foreign_key: :children_parameter_id
    end
  end
end

ROM_CONFIG.register_relation(Parameters, ChildrenParents, Categories)
ROM_CONFIG.register_command(CreateParameters)
