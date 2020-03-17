class CreateQueryResults < ActiveRecord::Migration[6.0]
  def change
    create_table :query_results do |t|
      t.references :query, null: false, foreign_key: true
      t.text :text
      t.text :link

      t.timestamps
    end
  end
end
