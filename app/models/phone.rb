class Phone < ActiveRecord::Base
  # this auto inserted when did command: rails g model phone fieldname:fieldtype tabletolinkto:references
  belongs_to :user
end
