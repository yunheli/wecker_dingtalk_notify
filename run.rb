#!/usr/bin/env ruby

require "rest-client"
require "json"

class DingTalk
  attr_accessor :webhook_url, :message
  def initialize(webhook_url, fail_message = nil, success_message = nil)
    self.webhook_url = webhook_url
    self.message ||= fail_message
    self.message ||= success_message
    self.message ||= "测试"
  end

  def send(msg = nil)
    message = msg unless msg
    RestClient.post(webhook_url, payload.to_json, {content_type: :json})
  end

  def payload
    {
       "msgtype"=> "markdown",
       "markdown"=> {
           "title"=>"消息来了",
           "text"=> message
       }
    }
  end
end

webhook_url = ENV["webhook_url"]
success_message = ENV["passed_message"]
fail_message = ENV["failed_message"]
DingTalk.new(webhook_url, success_message, fail_message).send
