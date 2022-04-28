# Implement an automated SMS message when a callback is not answered (DRAFT)

This Genesys cloud blueprint demonstrates how to send an SMS message to a customer when an agent attempts to reach a customer on a callback and the customer is unavailable.

This blueprint also demonstrates how to:

* Build an event trigger that will listen to and inspect a conversation event and look for unavailable customer callback wrap-up codes.
* Build an Architect workflow for processing an incoming conversation event and triggering an SMS message off of it.
* Build a Data action that invokes the Genesys Cloud SMS public api endpoint. 

![Implement an automated SMS message when a callback is not answered](/blueprint/images/overview_no_numbers.png "Implement an automated SMS message when a callback is not answered")
