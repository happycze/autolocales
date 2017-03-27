Sequel::Model.plugin(:schema)
Sequel::Model.plugin(:timestamps) # All models will have timestamps created_at and updated_at
Sequel::Model.plugin(:json_serializer) # All model will be serializable to json
Sequel::Model.plugin(:update_or_create) # There is find and update, or create method available for all models
Sequel::Model.plugin(:validation_helpers) # Enable validation helpers

Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect("sqlite://db/autolocales_development.db", :loggers => [logger]) # Windows! https://github.com/padrino/padrino-framework/issues/1803
  when :production  then Sequel.connect("mysql2://db_user:db_pass@localhost/padrino_production.db",  :loggers => [logger])
end
