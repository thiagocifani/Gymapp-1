class CreateGymcards < ActiveRecord::Migration[5.0]
  def change
    create_table :gymcards do |t|
      t.integer :employee_id
      t.integer :client_id

      t.timestamps
    end
  end
end
