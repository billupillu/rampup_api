class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.references :user, foreign_key: true
      t.string :info
      t.string :course
      t.string :activity
      t.string :iframe
      t.text :description

      t.timestamps
    end
  end
end
