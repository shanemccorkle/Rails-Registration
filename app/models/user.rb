class User < ActiveRecord::Base
  # make username field unique
  validates :username, uniqueness:true
  # this auto inserted when did command: rails g model phone fieldname:fieldtype tabletolinkto:references
  has_many :phones
end
