# OAuth client credentials for Agentless Public API (different from Terraform OAuth client)
callback_sms_oauthclient="your_sms_oauth_client_id"
callback_sms_oauthsecret="your_sms_oauth_client_secret"

# SMS-enabled phone number purchased from Genesys Cloud (E.164 format)
callback_originating_sms_phonenumber="+19206775555"

# Phone number customers should call to reschedule (included in SMS message)
callback_phonenumber="+18005551213"

# Agent email address for the callback queue
callback_agent_email="your.agent@example.com"

# Division for the flow deployment (default: "Home")
callback_division="Home"

# Example with actual values (replace with your values):
# callback_sms_oauthclient="3xxxx5d2-acbd-4709-a652-4114f1d88888"
# callback_sms_oauthsecret="vjbhxWqwObEg7ZYGdxxxxo0PC2iKu22OwCPz0pgQj5M"
# callback_originating_sms_phonenumber="+19206775555"
# callback_phonenumber="+18005551213"
# callback_agent_email="john.smith@genesys.com"
# callback_division="Home"