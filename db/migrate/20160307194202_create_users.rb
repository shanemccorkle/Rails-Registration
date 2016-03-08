class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :firstname
      t.string :lastname
      t.string :streetaddr
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :email

      t.timestamps null: false
    end
  end
end
