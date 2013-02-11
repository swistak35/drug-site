class RemainderMailer < ActionMailer::Base
  default from: ENV['CONTACT_EMAIL']

  def day_before(receiver, event)
    @event = event
    @width = 100 + rand(701)
    @height = (@width.to_f * 3 / 4).to_i
    
    mail to: receiver.email, subject: "#{@event.title} IS COMING"
  end
end
