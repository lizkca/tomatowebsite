class CreateTomatoes < ActiveRecord::Migration[8.0]
  def change
    create_table :tomatoes do |t|
      t.text :note

      t.timestamps
    end
  end
end
