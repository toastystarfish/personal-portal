class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    # used to invite a user - typically sent via email
    create_table :invitations do |t|
      t.string :email, :null => false           # email to send invite to
      t.string :token,  :null => false          # token sent via email for
                                                # one-time used

      t.integer :invited_by_id, :null => false  # points to a user

      t.datetime :sent_at                       # when invite email was sent
      t.datetime :accepted_at                   # when invite was accepted

      t.timestamps null: false
    end
  end
end
