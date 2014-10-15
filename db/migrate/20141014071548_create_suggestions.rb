class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :suggestion_id
      t.string :name
      t.text :description
      t.integer :score, :default => 1

      t.timestamps
    end
  end
end
