class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.boolean :gender

      t.timestamps
    end
  end
end
