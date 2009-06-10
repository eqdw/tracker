class Bug < ActiveRecord::Base
  belongs_to :user

  
  def self.find_bugs
    find(:all, :order => "reporter")
  end
end
