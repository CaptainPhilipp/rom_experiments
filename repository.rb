class CategoryRepo < ROM::Repository[:categories]
  relations :tags

  commands :create
end
