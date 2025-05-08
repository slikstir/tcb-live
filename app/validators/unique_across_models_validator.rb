class UniqueAcrossModelsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    models = options[:models] + [ record.class ]

    models.each do |model|
      query = model.where(attribute => value)

      # Exclude the current record if it's already persisted (for updates)
      query = query.where.not(id: record.id) if record.persisted?

      if query.exists?
        record.errors.add(attribute, "has already been taken in #{model.name}")
      end
    end
  end
end
