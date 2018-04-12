class CreateResearchTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :research_tokens do |t|
      t.references :research
      t.string :token
      t.integer :grade

      t.timestamps
    end

    add_index :research_tokens, :token, unique: true
  end
end
