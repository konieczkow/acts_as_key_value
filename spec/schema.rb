ActiveRecord::Schema.define :version => 0 do
  create_table :basic_models do |t|
    t.string :key, :null => false
    t.string :value
  end

  add_index :basic_models, :key, :unique => true
end