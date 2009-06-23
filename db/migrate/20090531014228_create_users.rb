#user belongs_to :company
#user has_many :bugs

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.boolean :admin

      t.integer :company_id, :options => "CONSTRAINT fk_user_companies REFERENCES companies(id)"

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
