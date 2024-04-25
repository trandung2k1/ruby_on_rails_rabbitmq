# config/initializers/rabbitmq.rb

require 'bunny'

RABBITMQ_URL = ENV['RABBITMQ_URL']

module RabbitMQ
  class << self
    def connection
      @connection ||= Bunny.new("amqp://localhost").tap(&:start)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def exchange
      @exchange ||= channel.default_exchange
    end
    def create_queue(queue_name)
        channel.queue(queue_name)
    end

    def publish(exchange, message = {})
      # grab the fanout exchange
      x = channel.fanout("blog.#{exchange}")
      # and simply publish message
      x.publish(message.to_json)
    end
  end
end
