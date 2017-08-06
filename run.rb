require_relative 'config'
require_relative 'migration'
require_relative 'command'
require_relative 'relations'

CONTAINER = ROM.container(ROM_CONFIG)

require_relative 'repository'

category_repo = CategoryRepo.new(CONTAINER)

category = category_repo.changeset(title: 'Hello World')

parameters = category_repo
         .changeset(:parameters, [{ title: 'red' }, { title: 'green' }])
         .with(command_type: :fetch_or_create)

# return parameters associated with the category
category_repo.transaction do
  puts "\n" + category.associate(parameters, :parent_categories).commit.inspect
end

# return category associated with the parameters
category_repo.transaction do
  puts "\n" + parameters.associate(category, :children_parameters).commit.inspect
end

# commit separately and return what you need
category_repo.transaction do
  new_parameters = parameters.commit
  new_category = category.associate(new_parameters, :parameters).commit

  puts "\n" + new_category.inspect
end

category_repo
