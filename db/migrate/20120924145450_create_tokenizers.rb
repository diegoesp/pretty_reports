class CreateTokenizers < ActiveRecord::Migration
  def change
    create_table :tokenizers do |t|
      t.string :uid
      t.integer :user_id

      t.timestamps
    end
  end
end
