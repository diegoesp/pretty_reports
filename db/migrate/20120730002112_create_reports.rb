class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :report_type
      t.string :title
      t.string :subtitle
      t.string :content1
      t.string :content2
      t.string :content3
      t.timestamps
    end
  end
end
