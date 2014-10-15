class Suggestion < ActiveRecord::Base
  attr_readonly :name, :description, :suggestion_id
end
