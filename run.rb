require_relative 'config'
require_relative 'migration'
require_relative 'command'
require_relative 'relations'

container = ROM.container(ROM_CONFIG)

require_relative 'repository'

params_repo = ParameterRepo.new(container)
cat_repo    = CategoryRepo.new(container)

cat_changeset = cat_repo.changeset(title: 'Hello World')

# parameters = cat_repo
#          .changeset(:parameters, [{ title: 'red' }, { title: 'green' }])
#          .with(command_type: :fetch_or_create)
#
# # return parameters associated with the category
# cat_repo.transaction do
#   puts "\n" + cat_changeset.associate(parameters, :parent_categories).commit.inspect
# end
#
# # return category associated with the parameters
# cat_repo.transaction do
#   puts "\n" + parameters.associate(cat_changeset, :children_parameters).commit.inspect
# end
#
# # commit separately and return what you need
# cat_repo.transaction do
#   new_parameters = parameters.commit
#   new_category = cat_changeset.associate(new_parameters, :children_parameters).commit
#
#   puts "\n" + new_category.inspect
# end

# return parameters associated with the category
cat_repo.transaction do
  puts "\n" + cat_repo.with_parameters.inspect
end
