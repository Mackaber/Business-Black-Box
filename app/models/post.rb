class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :category, :content, :votedown, :voteup
end
