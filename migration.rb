migration = ROM_CONFIG.gateways[:default].migration do
  change do
    create_table?(:categories) do
      primary_key :id
      column :title, String, null: false
    end

    create_table?(:parameters) do
      primary_key :id
      column :title, String, null: false, unique: true
    end

    create_table?(:children_parents) do
      primary_key :id
      foreign_key :parent_category_id, :categories
      foreign_key :children_parameter_id, :parameters

      foreign_key :children_category_id, :categories
    end
  end
end

conn = ROM_CONFIG.gateways[:default].connection

migration.apply(conn, :up)
