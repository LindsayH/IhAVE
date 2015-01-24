class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.datetime :date_due
      t.datetime :date_returned
      t.string :borrower_name
      t.integer :times_lent
      t.references :item, index: true

      t.timestamps
    end
  end
end
