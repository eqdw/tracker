class Bug < ActiveRecord::Base
  belongs_to :user

  named_scope :last_n_days, lambda{|n|
    if n == 0
      {:conditions => ['bugs.created_at < ?', Date.tomorrow] }
    else
      {:conditions => ['bugs.created_at > ?', Date.today - n.days]}
    end
  }

  
  def self.find_bugs
    find(:all, :order => "reporter")
  end
end
