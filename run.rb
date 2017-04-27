#!/usr/bin/env ruby

require "rest-client"
require "json"

class DingTalk
  attr_accessor :webhook_url, :message
  def initialize(webhook_url, fail_message = nil, success_message = nil)
    self.webhook_url = webhook_url
  end

  def send(msg = nil)
    self.message = msg if msg
    res = RestClient.post(webhook_url, payload.to_json, {content_type: :json})
  end

  def payload
    {
       "msgtype"=> "markdown",
       "markdown"=> {
           "title"=>"消息来了 ",
           "text"=> message
       }
    }
  end
end

webhook_url = ENV["WERCKER_DINGTALK_NOTIFY_WEBHOOK_URL"]
message = ENV["WERCKER_DINGTALK_NOTIFY_MESSAGE"]
DingTalk.new(webhook_url).send(message)
