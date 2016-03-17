class Group < ActiveRecord::Base
  has_paper_trail

  belongs_to :owner, class_name: User

  def to_s
    self.name
  end

  def users
    User.where(id: self.user_ids)
  end
end
