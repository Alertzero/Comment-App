class AddColorToInboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :inboxes, :color, :string, null: false, default: "#f5a623"
  end
end
