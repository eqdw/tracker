class Bug < ActiveRecord::Base
  belongs_to :user

  named_scope :solved, lambda{|str|
    if str == "Yes" 
      {:conditions => 'solved = true'}
    else # str == "No"
      {:conditions => 'solved = false'}
    end
  }

  named_scope :last_n_days, lambda{|days|
    unless days == 0
      {:conditions => ['created_on < ?', days]}
    end
  }

  
  def self.find_bugs
    find(:all, :order => "reporter")
  end
end
