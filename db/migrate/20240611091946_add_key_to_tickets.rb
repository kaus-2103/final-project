class AddKeyToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :key, :string
  end
end
