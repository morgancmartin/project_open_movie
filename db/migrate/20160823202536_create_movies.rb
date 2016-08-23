class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.string :location
      t.text :fun_facts
      t.string :production_company
      t.string :distributor
      t.string :director
      t.string :writer
      t.string :actor_1
      t.string :actor_2
      t.string :actor_3

      t.timestamps
    end
  end
end
