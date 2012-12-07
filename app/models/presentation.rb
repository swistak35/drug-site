class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :presentation_type
  validates :title, presence: true

  scope :not_postponed, where("status != 'postponed'")
  scope :postponed, where(status: 'postponed')
  scope :done, where(status: 'done')

  delegate :full_name, to: :user, prefix: true

  def postpone!
    self.status = 'postponed'
    self.save!
  end

  def cancel_postponement!
    self.status = 'submitted'
    self.save!
  end

  def postponed?
    self.status == 'postponed'
  end
end
