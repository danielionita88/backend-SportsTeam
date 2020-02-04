class AddDetailsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :details, :string
  end
end
