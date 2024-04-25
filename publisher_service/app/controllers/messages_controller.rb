class MessagesController < ApplicationController
  def create
    # RabbitMQ.exchange.publish(params[:message], routing_key: 'example.key')
    # head :created
    # queue_name = "HELLO"
    # RabbitMQ.create_queue(queue_name)
    
    @post = {"id": "1", "name": "Post 1"}
    RabbitMQ.publish("posts", @post)
    @user = {"name": "John", "age": 45}
    render :json => @user
  end
end
