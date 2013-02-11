namespace :remainders do
  desc "Send remainders 'day_before' to people."
  task :day_before => :environment do
    event = Event.closest_upcoming

    if Date.today.tomorrow == event.starting_at.to_date
      Person.where(remainder_day_before_drug: true).each do |person|
        RemainderMailer.day_before(person, event).deliver! if
          person.remainder_even_if_not_attending || person.attend?(event)
      end
    end
  end

  desc "Send remainders 'at_day_of' to people."
  task :at_day_of => :environment do
    event = Event.closest_upcoming

    if Date.today == event.starting_at.to_date
      Person.where(remainder_at_day_of_drug: true).each do |person|
        RemainderMailer.today(person, event).deliver! if
          person.remainder_even_if_not_attending || person.attend?(event)
      end
    end
  end
end