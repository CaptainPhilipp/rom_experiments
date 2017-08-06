class CreateParameters < ROM::SQL::Commands::Postgres::Upsert
  relation :parameters
  register_as :fetch_or_create
  result :many
  constraint 'parameters_title_key'

  def execute(tuples, *)
    result = super

    if result.empty?
      relation.where(title: Array(tuples).map { |t| t[:title] }).to_a
    else
      result
    end
  end
end
