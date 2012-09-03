class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :title,  :null => false
      t.string :author, :null => false
      t.integer :year,  :null => false
      t.text :text

      t.timestamps
    end
  end
end
