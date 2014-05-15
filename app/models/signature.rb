class Signature < ActiveRecord::Base
  attr_accessible :when, :user, :complaint

  belongs_to :user
  belongs_to :complaint
end
