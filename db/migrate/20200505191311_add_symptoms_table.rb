class AddSymptomsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :symptoms, force: :cascade do |t|
      t.string :name
      t.timestamps
    end

    create_table :contact_symptoms, force: :cascade do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :symptom
    end
  end
end
