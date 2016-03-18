class Location < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  def title
    self.user.to_s
  end

  def as_json(options = nil)
    default_options = {
      only: [:id, :latitude, :longitude, :user_id],
      methods: [:title]
    }

    super(default_options.merge(options || {}))
  end
end
