class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.references :tag, foreign_key: true
      t.references :link, foreign_key: true
    end
  end
end
