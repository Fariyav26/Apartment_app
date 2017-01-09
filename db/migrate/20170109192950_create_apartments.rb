class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :postal
      t.string :state
      t.string :country
      t.string :contact_name
      t.string :phone
      t.text :hours
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
