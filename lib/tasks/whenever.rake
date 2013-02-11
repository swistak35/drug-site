namespace :whenever do
  desc "Send remainders 'day_before' to people."
  task :send_remainders_day_before => :environment do
    event = Event.closest_upcoming
    if Date.today.tomorrow == event.starting_at.to_date
      People.where(remainder_day_before_drug: true).each do |person|
        RemainderMailer.day_before(event, person).deliver! if
          person.remainder_even_if_not_attending || person.attend?(event)
      end
    end
  end

  desc "Send remainders 'at_day_of' to people."
  task :remainder_at_day_of_drug => :environment do
    event = Event.closest_upcoming
    if Date.today == event.starting_at.to_date
      People.where(remainder_at_day_of_drug: true).each do |person|
        RemainderMailer.today(event, person).deliver! if
          person.remainder_even_if_not_attending || person.attend?(event)
      end
    end
  end
end