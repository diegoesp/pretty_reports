class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.float :cost
      t.boolean :active

      t.timestamps
    end
  end
end
