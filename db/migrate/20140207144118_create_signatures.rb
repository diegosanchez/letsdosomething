class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.belongs_to  :user
      t.belongs_to  :complaint
      t.datetime    :when

      t.timestamps
    end
  end
end
