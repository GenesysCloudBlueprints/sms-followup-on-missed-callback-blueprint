terraform {
  required_providers {
    genesyscloud = {
     #source = "mypurecloud/genesyscloud"
     source = "genesys.local.com/mypurecloud/genesyscloud"
     version = "0.1.0"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = false
}

data "genesyscloud_user" "callback_agent" {
  email = var.callback_agent_email
}

module "callback_sms_integration" {
    source = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module.git?ref=main"

    integration_name                = "Callback SMS Integrations"
    integration_creds_client_id     = var.callback_sms_oauthclient
    integration_creds_client_secret = var.callback_sms_oauthsecret
}

module "callback_sms_dataaction" {
    source             = "git::https://github.com/GenesysCloudDevOps/public-api-send-sms-data-action-module.git?ref=main"
    action_name        = "Send SMS"
    action_category    = "${module.callback_sms_integration.integration_name}"
    integration_id     = "${module.callback_sms_integration.integration_id}"
    secure_data_action = false
}

resource "genesyscloud_routing_wrapupcode" "cust_unavailable" {
  name = "Cust unavailable"
}


resource "genesyscloud_routing_queue" "sms_callback_queue" {
  name                     = "smsa"
  description              = "SMS Callback Queues"
  acw_wrapup_prompt        = "MANDATORY_TIMEOUT"
  acw_timeout_ms           = 300000
  skill_evaluation_method  = "BEST"
  auto_answer_only         = true
  enable_transcription     = true
  enable_manual_assignment = true
  wrapup_codes             = [genesyscloud_routing_wrapupcode.cust_unavailable.id]
  members {
    user_id = data.genesyscloud_user.callback_agent.id
    ring_num=1
  }
}

resource "genesyscloud_flow" "sms_eventrigger_flow" {
  depends_on = [
    module.callback_sms_dataaction
  ]  
  filepath = "${path.module}/architect/callback_sms_eventrigger_flow.yaml.tftpl"
  substitutions = {
    callback_originating_sms_phonenumber            = var.callback_originating_sms_phonenumber
    callback_phonenumber                            = var.callback_phonenumber
  }
}

resource "genesyscloud_processautomation_trigger" "trigger" {
  name       = "MyUnansweredCallbackTrigger"
  topic_name = "v2.detail.events.conversation.{id}.acw"
  enabled    = true

  target {
    id   = genesyscloud_flow.sms_eventrigger_flow.id
    type = "Workflow"
  }
  match_criteria {
        json_path =  "queueId"
        operator  =  "Equal"
        value     =  genesyscloud_routing_queue.sms_callback_queue.id
  }
  match_criteria  {
        json_path =  "wrapupCode"
        operator  =  "Equal"
        value     =  genesyscloud_routing_wrapupcode.cust_unavailable.id
  }
  match_criteria{
        json_path =  "mediaType"
        operator  =  "Equal"
        value     =  "CALLBACK"
  }

   event_ttl_seconds = 60
} 



