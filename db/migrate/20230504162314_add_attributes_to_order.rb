class AddAttributesToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :code, :string
    add_column :orders, :status, :integer, default: 0
  end
end
