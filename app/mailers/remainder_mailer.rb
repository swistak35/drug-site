class RemainderMailer < ActionMailer::Base
  default from: ENV['CONTACT_EMAIL']

  def day_before(receiver, event)
    @event = event
    generate_cat_stuff

    mail to: receiver.email, subject: "#{@event.title} IS COMING"
  end

  def today(receiver, event)
    @event = event
    generate_cat_stuff

    mail to: receiver.email, subject: "#{@event.title} IS COMING"
  end

private
  def generate_cat_stuff
    @width = 100 + rand(701)
    @height = (@width.to_f * 3 / 4).to_i
  end
end
