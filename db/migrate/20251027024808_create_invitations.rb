class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.references :invitee, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
