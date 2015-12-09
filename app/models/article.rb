class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :foreign_key => :article_id
  validates :title,  :presence => true
  validates :body,  :presence => true
end
