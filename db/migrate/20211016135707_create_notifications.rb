class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.references :user, null: false, foreign_key: true
      t.references :notifiable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
