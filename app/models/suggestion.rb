class Suggestion < ActiveRecord::Base
  attr_readonly :name, :description, :suggestion_id
  acts_as_taggable

  #Time in seconds when the user can destroy the record after creating
  EPHEMERAL_LIFE = 60

  def is_ephemeral?
    (Time.now - self.created_at).to_i < EPHEMERAL_LIFE
  end

  def ephemeral_life_remaining
    [EPHEMERAL_LIFE - (Time.now - self.created_at).to_i, 0].max
  end
end
