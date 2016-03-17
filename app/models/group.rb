class Group < ActiveRecord::Base
  has_paper_trail

  belongs_to :owner, class_name: User

  def to_s
    self.name
  end

  def users
    User.where(id: [self.owner_id, self.user_ids].flatten.uniq)
  end

  def last_locations_except_for_me(user)
    self.users.where.not(id: user.id).map do |user|
      user.locations.order(id: :desc).first
    end.compact
  end
end
