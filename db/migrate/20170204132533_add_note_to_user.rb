class AddNoteToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :note, :string, default: ''
  end
end
