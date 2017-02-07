Webhooks
--------------

Snowflake has suficticated webhook support that enables you to keep your internal solutions up-to-date with everything related to communications triggered by Snowflake. Snowflake will make a POST request to the configured URL containing one or multiple events. These events also contain a copy of the actual sent message so you can use this to display the message in your internal solutions.  Below here is the data structure described in detail.

### Sent

```
{
  "events": [
    {
      "event": "send",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email | sms",
      "message": {... see message payload below ...}
      }
    }
  ]
}
```

### Failed

```
{
  "events": [
    {
      "event": "failed",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email | sms",
      "message": {... see message payload below ...},
      "errors": []
      }
    }
  ]
}
```


### Open

```
{
  "events": [
    {
      "event": "open",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email",
      "message": {... see message payload below ...},
      "data" : {
        "client_ip" : "8.8.8.8",
        "user_agent" : "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0"
      }
    }
  ]
}
```

### Click

```
{
  "events": [
    {
      "event": "click",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email | sms",
      "message": {... see message payload below ...},
      "data" : {
        "client_ip" : "8.8.8.8",
        "url" : "mailto:mark@snowflake.ai",
        "user_agent" : "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0"
      }
    }
  ]
}
```

### Bounce

```
{
  "events": [
    {
      "event": "bounce",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email",
      "message": {... see message payload below ...},
      "data" : {
        "timestamp": "2016-09-11T14:00:10.136Z",
        "bounceType": "Permanent",
        "feedbackId": "01020157198c5646-abb3a6f6-8fe1-474a-a5ce-75a31114a84e-000000",
        "reportingMTA": "dsn; a4-10.smtp-out.eu-west-1.amazonses.com",
        "bounceSubType": "General",
        "bouncedRecipients": [{
          "action": "failed",
          "status": "5.1.1",
          "emailAddress": "bounce@simulator.amazonses.com",
          "diagnosticCode": "smtp; 550 5.1.1 user unknown"
          }
        ]
      }
    }
  ]
}
```

### Delivery

```
{
  "events": [
    {
      "event": "delivery",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email | sms",
      "message": {... see message payload below ...},
      "data" : {
        "timestamp": "2016-09-11T14:01:32.436Z",
        "recipients": ["complaint@simulator.amazonses.com"],
        "reportingMTA": "a4-9.smtp-out.eu-west-1.amazonses.com",
        "smtpResponse": "250 2.6.0 Message received",
        "processingTimeMillis": 2559
      }
    }
  ]
}
```

### Complaint

```
{
  "events": [
    {
      "event": "complaint",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "email | sms",
      "message": {... see message payload below ...},
      "data" : {
        "timestamp": "2016-09-11T14:01:32.000Z",
        "userAgent": "Amazon SES Mailbox Simulator",
        "feedbackId": "01020157198d9cbc-3f308d28-7828-11e6-a427-a910cd874576-000000",
        "complainedRecipients": [{"emailAddress": "complaint@simulator.amazonses.com"}],
        "complaintFeedbackType": "abuse"
      }
    }
  ]
}
```

### Reply

```
{
  "events": [
    {
      "event": "reply",
      "occured_at": "2017-01-25T20:56:53",
      "message_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "communication_id": "3ab48f4e-c0eb-46fb-9b76-bae613f418cd",
      "contact_id": "your contact id",
      "channel": "sms",
      "message": {... see message payload below ...},
      "data" : {
        "body": "The sms reply text"
      }
    }
  ]
}
```

### Email message

```
{
  "to_name": "Mark Nijhof",
  "to": "mark@snowflake.ai",
  "subject": "Welcome to Snowflake!",
  "id": "2c09a6ce-e18e-46bc-9e9a-632024cce58f",
  "from_name": "Snowflake Support",
  "from": "support@snowflake.ai",
  "body_html": "The HTML email body",
  "body": "The plain text email body",
  "attachments": null
}
```

### SMS message

```
{
  "to": "+4746748688",
  "from": "Snowflake",
  "body": "The SMS text",
  "id": "2c09a6ce-e18e-46bc-9e9a-632024cce58f"
}
```

