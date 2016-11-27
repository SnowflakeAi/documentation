Developer API
================

Welcome to the Snowflake API.

The Snowflake API is organized around [REST](http://en.wikipedia.org/wiki/Representational_State_Transfer). Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which are understood by off-the-shelf HTTP clients. We support cross-origin resource sharing, allowing you to interact securely with our API from a client-side web application (though you should never expose your secret API key in any public website's client-side code). [JSON](http://www.json.org/) is returned by all API responses, including errors.

Authentication
--------------

Authenticate your account when using the API by including your secret API key in the request. You can manage your API keys in the [Dashboard](https://app.snowflake.ai/#/admin/api_access). Your API keys carry many privileges, so be sure to keep them secret! Do not share your secret API keys in publicly accessible areas such GitHub, client-side code, and so forth.

```
curl "https://api.snowflake.ai" \
-H "Content-Type: application/json"
-H "Authorization: Bearer {{your api key}}"
```

You will need to authenticate via bearer auth (e.g., for a cross-origin request), use -H "Authorization: Bearer {{your api key}}" instead of -u {{your api keyB}}:.
All API requests must be made over [HTTPS](http://en.wikipedia.org/wiki/HTTP_Secure). Calls made over plain HTTP will fail. API requests without authentication will also fail.

Messages
--------

The `/messages` endpoint is used to trigger the sending of individual messages and also to retrieve the status of previously sent messages.

### Send a new message


```
curl "https://api.snowflake.ai/messages" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer {{your api key}}" \
-X POST \
-d '{
  "communicationId": "{{communication id}}",
  "environment": "draft",
  "data": {
    "channel": "sms",
    "foo": "Bar",
    "agent": {
      "phoneNumber": "+4712345678",
      "emailAddress": "sender@test.com",
      "name": "Sammy Sender"
    },
    "customer": {
      "phoneNumber": "+4787654321",
      "emailAddress": "recipient@test.com",
      "name": "Roger Recipient"
    }
  }
}'
```
The command returns JSON structured like this:

```
{
  "id": "{{communication id}}",
  "href":"/api/messages/{{communication id}}"
}
```

This endpoint sends a new message via the appropriate channel.

The example assumes that the templates are set up to use the agents email / phone number as sender email / phone number and the customers email / phone number as the recipient email / phone numbers.

The data in the message needs to match the schema used for the given communication.

### HTTP Request

POST https://api.snowflake.ai/messages

#### Parameters

Parameter | Description
----------|------------
communicationId | The ID of the communication you want to send
environment | The environment to pick a template from. Either ‘draft’ or 'release’ at this point.
data | The data you want to use to send the message

### Get a Specific Message

This endpoint retrieves a specific message.

```
curl "https://api.snowflake.ai/messages/{{message id}}" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer {{your api key}}"
```
The above command returns JSON structured like this:

```
{
  "id": "{{message id}}",
  "status": "sent",
  "opens": 2,
  "clicks": 1
}
```


### HTTP Request

GET https://api.snowflake.ai/messages/<ID>

##### URL Parameters

Parameter | Description
----------|------------
ID | The ID of the message to retrieve

### List messages

```
curl "https://api.snowflake.ai/messages/" \
-H "Authorization: Bearer {{your api key}}"
```

The above command returns JSON structured like this:

```
{
  "smsMessages":
  [
    {
      "to": "+4746748688",
      "status": "sent",
      "sentAt": "2015-11-19T17:49:15Z",
      "id": "004e49a0-d1e4-4a9d-a58b-308629868a50",
      "href": "/api/messages/004e49a0-d1e4-4a9d-a58b-308629868a50",
      "from": "+4712345678"
    }
  ],
  "emailMessages":
  [
    {
      "to": "foo@test.com",
      "status": "sent",
      "sentAt": "2015-11-07T08:59:37Z",
      "id": "674ae3bcad8d489d948055e6581ac590",
      "href": "/api/messages/674ae3bcad8d489d948055e6581ac590",
      "from": "bar@test.com"
    }
  ]
}
```

This endpoint lists messages sent from your account.

### HTTP Request

GET https://api.snowflake.ai/messages/






Errors
------

Snowflake uses conventional HTTP response codes to indicate the success or failure of an API request. In general, codes in the 2xx range indicate success, codes in the 4xx range indicate an error that failed given the information provided (e.g., a required parameter was omitted, a message failed, etc.), and codes in the 5xx range indicate an error with Snowflake's servers (these are rare) and should be retried again.

>Error|Code|Meaning
>-----|----|-------
>400 | Bad Request | Your request is invalid
>401 | Unauthorized | Your API key is wrong
>403 | Forbidden | You do not have access to the current resource
>404 | Not Found | The specified resource could not be found
>405 | Method Not Allowed | You tried to access a resource with an invalid method
>429 | Too Many Requests | You are exceeding our rate limits.
>500 | Internal Server Error | We had a problem with our server. Please try again later.
>503 | Service Unavailable | We’re temporarially offline for maintanance. Please try again later.
