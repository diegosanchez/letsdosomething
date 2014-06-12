class CreateProofs < ActiveRecord::Migration
  def change
    create_table :proofs do |t|
      t.belongs_to  :complaint
      t.string      :space
      t.string      :file

      t.timestamps
    end
  end
end
