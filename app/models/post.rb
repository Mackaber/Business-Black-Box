class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :category, :content, :votedown, :voteup
  
  has_reputation :votes, source: :user, aggregated_by: :sum
  
end
