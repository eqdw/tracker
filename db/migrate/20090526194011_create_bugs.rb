#bug belongs_to :user

class CreateBugs < ActiveRecord::Migration
  def self.up
    create_table :bugs do |t|
      t.string :subject
      t.text :description

      t.integer :user_id, :null => false, :options =>
        "CONSTRAINT fk_bug_users REFERENCES users(id)"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bugs
  end
end
