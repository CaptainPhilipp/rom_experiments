class CategoryRepo < ROM::Repository[:categories]
  relations :parameters

  commands :create
end
