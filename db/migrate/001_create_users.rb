Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :name
      String :login, :null=>false, :unique=>true
      String :password, :null=>false
      Integer :role, :null=>false, :default=>0
      TrueClass :validated, :null=>false, :default=>false
      DateTime :created_at
      DateTime :updated_at
      index :login
    end
  end

  down do
    drop_table :users
  end
end
