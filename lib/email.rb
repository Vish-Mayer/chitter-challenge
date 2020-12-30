require 'sendgrid-ruby'
require 'json'
include SendGrid


class Email
    def self.send(tagged_user:, user:)
    from = SendGrid::Email.new(email: ENV['FROM_EMAIL'])
    to = SendGrid::Email.new(email: tagged_user)
    subject = "#{user} has tagged you in a post!"
    content = SendGrid::Content.new(type: 'text/plain', value: "#{user} has tagged you in a post")
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
    p "emai sent"
  end
end
