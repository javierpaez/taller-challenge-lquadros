class NotificationJob < ApplicationJob
  queue_as :default

  def perform(book)
    message = {
      book_id: book.id,
      status: book.status,
      message: "Book status changed: 'Sample Book' is now 'checked_out'."
    }

    LogHelper.log(message)
  rescue StandardError => e
    LogHelper.exception(e, __method__, self)
  end
end
