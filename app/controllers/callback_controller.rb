class CallbackController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    if params['hub.verify_token'] == 'vanthu123'
      render html: params['hub.challenge']
    end
  end

  def receive_data
    the_request = request.body.read
    data = JSON.parse(the_request)
    list_message = parse_data(data)
    list_message.each do |message|
      send_message(message[0], message[1])
    end
  end

  def parse_data(data)
    messages = []
    entries = data['entry']

    entries.each do |entry|
      entry['messaging'].each do |message|
        sender = message['sender']['id']
        text = message['message']['text']
        messages << [sender, text]
      end
    end
    messages
  end

  def send_message(sender, text)
    message_json = {"recipient": {"id": "#{sender}"}, "message": {"text": "#{text}"}}
    puts message_json
    puts HTTP.post(url, json: message_json)
  end

  def url
    "https://graph.facebook.com/v2.6/me/messages?access_token=EAAFgDLghAfABAAPejUyZBxZAhzSJJCvjeSFwkH4dLvHakRQfph6Yuga8zC0t8Njoa2ZBZAxaAR0aoNexhL16vBWzmYZAyfkLcQX8GYZBsb28ixZA2YVz5ZCPjaffZCgQR9ArHdbU6RTzjf9eYilO16XExpMAXd5dp0EBz1FR5JtTySYQ25o7lXb5a"
  end
end
