class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where(["length < 20"])
  end

  def self.ship
    all.where(["length > 20"])
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  # returns boats without a captain
  def self.without_a_captain
    all.where(captain_id: nil)
  end

  # returns all boats that are sailboats
  def self.sailboats
     all.includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  # returns boats with three classifications
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  # returns the longest boat
  def self.longest
    order('length DESC').first
  end

end
