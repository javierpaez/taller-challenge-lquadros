class LogHelper
  def self.log(message, log_type = 'info')
    Rails.logger.send(log_type, message)
  end

  def self.exception(exception, method, klass)
    tags = { 
      message: "Error when tried to process the method #{method}",
      class: klass,
      log: { message: exception.message, class: exception.class }
    }

    log(tags)
  end
end