class CreateResearches < ActiveRecord::Migration[5.0]
  def change
    create_table :researches do |t|
      t.boolean :concluded, default: false

      t.timestamps
    end
  end
end
