require_relative 'config'
require_relative 'migration'
require_relative 'command'
require_relative 'relations'

CONTAINER = ROM.container(ROM_CONFIG)

require_relative 'repository'

category_repo = CategoryRepo.new(CONTAINER)

category = category_repo.changeset(title: 'Hello World')

tags = category_repo
         .changeset(:tags, [{ name: 'red' }, { name: 'green' }])
         .with(command_type: :fetch_or_create)

# return tags associated with the category
category_repo.transaction do
  puts "\ncategory.associate(tags, :categories).commit.inspect"
  puts category.associate(tags, :parent_categories).commit.inspect
end

# return category associated with the tags
category_repo.transaction do
  puts "\ntags.associate(category, :tags).commit.inspect"
  puts tags.associate(category, :tags).commit.inspect
end

# commit separately and return what you need
category_repo.transaction do
  new_tags = tags.commit
  new_category = category.associate(new_tags, :tags).commit

  puts new_category.inspect
end

category_repo
