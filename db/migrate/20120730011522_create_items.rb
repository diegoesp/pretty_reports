class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type
      t.text :content
      t.references :report

      t.timestamps
    end
    add_index :items, :report_id
  end
end
