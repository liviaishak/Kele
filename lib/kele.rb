require 'httparty'
require 'json'
require './lib/roadmap'


class Kele

  include HTTParty
  include RoadMap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post(api_url("sessions"), body: { "email": email, "password": password })
    raise 'Invalid Email and/or Password' if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url('users/me'), headers: { "authorization" => @auth_token })
    @user = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page_number=nil)
    if page_number
      response = self.class.get(api_url("message_threads"), body: { page: page_number }, headers: {"authorization" => @auth_token })
    else
      response = self.class.get(api_url("message_threads"), headers: {"authorization" => @auth_token })
    end
    JSON.parse(response.body)
  end

  def create_message(email, recipient_id, subject, message)
    self.class.post(api_url("messages"), body: { "sender" => email, "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => message }, headers: { "authorization" => @auth_token })
  end

  private
  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
