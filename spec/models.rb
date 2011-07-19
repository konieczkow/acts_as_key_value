class BasicModel < ActiveRecord::Base
  acts_as_key_value
end

class TrueObject < ActiveRecord::Base
  acts_as_key_value :object => true
end