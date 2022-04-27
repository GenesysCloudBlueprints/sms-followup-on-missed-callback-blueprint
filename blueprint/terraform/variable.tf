variable "callback_sms_oauthclient" {
  type        = string
  description = "Oauth client id the SMS data action will operate under"
}

variable "callback_sms_oauthsecret" {
  type        = string
  description = "Oauth client secret the SMS data action "
}

variable "callback_originating_sms_phonenumber" {
  type        = string
  description = "Phone number used to send SMS message. "
}

variable "callback_phonenumber" {
  type        = string
  description = "Phone number in the text message that the customer should call back into"
}

variable "callback_agent_email" {
  type        = string
  description = "Email address of the agent we want to associate with the queue. This will be the agent who is going to answer the callback and mark the customer as unavailable"
}

