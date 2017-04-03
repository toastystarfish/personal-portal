class Invitation < ActiveRecord::Base
  belongs_to :invited_by, class_name: "User", foreign_key: "invited_by_id"

  belongs_to :user, foreign_key: "email", primary_key: "email", required: false

  # updates the 'accepted_at' field in the invitation
  # TODO: Probably not needed - seems logic-y
  def accept
    self.accepted_at = Time.zone.now
    self.save
  end

  ## Other possiblities could be using base54 (base64 minus non alphanumerics,
  ## and hard to read characters such as 0O1l), which is what rails
  ## secret_token.rb class uses
  ##
  ## Also looked at uuid, but most of the reading we did said it really
  ## doesn't make much of a difference. As long as it url friendly, which
  ## hex is.
  ##
  ## TODO: Do we expire the token? Can it only be used once?
  def self.generate_token
    SecureRandom.hex
  end
end
