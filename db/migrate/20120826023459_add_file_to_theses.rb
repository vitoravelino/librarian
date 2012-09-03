class AddFileToTheses < ActiveRecord::Migration
  def change
    add_column :theses, :file, :string
  end
end
