class AddAttachmentProveToComplaints < ActiveRecord::Migration
  def self.up
    change_table :complaints do |t|
      t.attachment :prove
    end
  end

  def self.down
    drop_attached_file :complaints, :prove
  end
end
