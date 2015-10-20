class AddStaticToEvents < ActiveRecord::Migration
  def change
    add_column :events, :static, :boolean, :default => false
  end
end
