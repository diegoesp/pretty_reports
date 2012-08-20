class AddDirtyAndGeneratingToReport < ActiveRecord::Migration
  def change
    add_column :reports, :generating, :boolean, default: false
    add_column :reports, :dirty, :boolean, default: false
  end
end
