class League < ApplicationRecord
  has_many :league_users
  has_many :users, through: :league_users
  has_many :league_teams
  has_many :teams, through: :league_teams
  has_many :league_players
  has_many :players, through: :league_players

  validates_presence_of :name,
            						:commissioner,
            						:headquarters,
            						:inaugural_season,
            						:number_of_teams,
            						:abbreviation,
                        :users

  validates_uniqueness_of :name, scope: [ :commissioner ]
  validate :prevent_basic_users

  def prevent_basic_users
    begin
      self.users.each do |u|
        user = User.find_by(username: u.username)
        if user.type == 'AdminUser'
          self.users.each do |t|
            if t.type == 'BasicUser'
              self.errors.add(:basic_user_permission, "to join #{self.name} not granted")
            end
          end
        end
      end
      
    rescue => e
      self.errors.add(:basic_user_permission, e.message)
    end
  end


  
end
