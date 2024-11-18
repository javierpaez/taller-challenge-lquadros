class Book < ApplicationRecord
  validates :title, :author, :publication_year, presence: true

  validates :title, uniqueness: { scope: :author }

  validates :rating, inclusion: { in: 0..5 }

  enum status: {
    available: 'available',
    checked_out: 'checked_out',
    reserved: 'reserved'
  }

  after_update :notification

  private

  def notification
    return unless status_changed?(from: :available, to: :checked_out)

    NotificationJob.perform_later(self)
  end
end
