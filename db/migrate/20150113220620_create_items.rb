class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.boolean :is_out
      t.date :due_date
      t.references :location, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
