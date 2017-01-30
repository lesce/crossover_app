class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :content
      t.integer :status
      t.references :user

      t.timestamps

    end
    add_index :tickets, :status
  end
end
