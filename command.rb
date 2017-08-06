class CreateParameters < ROM::SQL::Commands::Postgres::Upsert
  relation :parameters
  register_as :fetch_or_create
  result :many
  constraint 'parameters_name_key'

  def execute(tuples, *)
    result = super

    if result.empty?
      relation.where(name: Array(tuples).map { |t| t[:name] }).to_a
    else
      result
    end
  end
end
