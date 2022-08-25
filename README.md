# Implement an automated SMS message when a callback is not answered

This Genesys cloud blueprint demonstrates how to send an SMS message to a customer when an agent attempts to reach a customer on a callback and the customer is unavailable.

This blueprint also demonstrates how to:

* Build an event trigger that checks the conversation events and looks for wrap-up codes which are selected for callback due to customer unavailability.
* Build an Architect workflow for processing an incoming conversation event and send an SMS message to the customer.
* Build a data action that invokes the Genesys Cloud SMS public API endpoint. 

![Implement an automated SMS message when a callback is not answered](blueprint/images/sms-process-automation.png "Implement an automated SMS message when a callback is not answered")

:::primary
You can be part of the process automation trigger beta program. To participate, contact the Product Manager Richard Schott at richard.schott@genesys.com.
:::
