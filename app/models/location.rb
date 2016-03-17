class Location < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
end
