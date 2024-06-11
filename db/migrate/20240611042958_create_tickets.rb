class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :summary
      t.string :priority
      t.string :status
      t.string :reported
      t.string :collection
      t.string :link

      t.timestamps
    end
  end
end
