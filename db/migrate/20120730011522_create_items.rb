class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type
      t.string :section
      t.string :title, :limit => 1024
      t.text :subtitle
      t.references :report
      t.timestamps
    end
    add_index :items, :report_id
  end
end
