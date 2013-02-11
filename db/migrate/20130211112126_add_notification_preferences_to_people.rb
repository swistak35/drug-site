class AddNotificationPreferencesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remainder_day_before_drug, :boolean
    add_column :people, :remainder_at_day_of_drug, :boolean
    add_column :people, :remainder_even_if_not_attending, :boolean
  end
end
