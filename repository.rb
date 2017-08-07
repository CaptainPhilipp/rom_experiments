class CategoryRepo < ROM::Repository[:categories]
  relations :parameters

  commands :create

  def with_parameters
    # aggregate(:children_parameters).to_a
    categories.combine(many: children_parameters)
  end
end

class ParameterRepo < ROM::Repository[:parameters]
  relations :categories

  commands :create
end
