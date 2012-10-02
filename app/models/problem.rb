class Problem < ActiveRecord::Base
  attr_accessible :published_at, :body, :solution, :issue_ids, :issue_id

  validates :body, :presence  => true,
                   :length    => { :in => 20..255 }

  belongs_to :user

  has_many :solutions, :order => "up_votes DESC, created_at DESC"

  has_many :issue_problems
  has_many :issues, :through => :issue_problems

  accepts_nested_attributes_for :solutions, :issues

  make_voteable

  scope :votes, order("up_votes DESC, created_at DESC")

  def solution
    solutions
  end

  def solution=(value)
    solutions = value
  end

  def issue
    issues.first
  end

end
