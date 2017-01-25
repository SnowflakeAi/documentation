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

This endpoint sends a new message via the appropriate channel.
<br/><br/>
in order to sent a message to an individual person you need to make a `POST` request to `https://api.snowflake.ai/messages` take a look at the command here on the side to see what is needed.
<br/><br/>
The example assumes that the templates are set up to use the agents email / phone number as sender email / phone number and the customers email / phone number as the recipient email / phone numbers.



```
curl "https://api.snowflake.ai/messages" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer {{your api key}}" \
-X POST \
-d '{
  "communicationId": "{{communication id}}",
  "contactId": "{{your customer id}}",
  "environment": "production",
  "data": {
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

#### Success

When successful the command will return a JSON structure like this:

```
{
  "id": "{{communication id}}",
  "href":"/api/messages/{{communication id}}"
}
```

The data in the message needs to match the contact schema that is defined in the Snowflake UI. If the contact doesn't exist in the Snowflake database then this will also add it, which means that future sent requests do not need to contain the all data. And if the contact does exist then it will be updated accordingly. This makes it possible to just start sending messages even before syncing all available customer data.

```
curl "https://api.snowflake.ai/messages" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer {{your api key}}" \
-X POST \
-d '{
  "communicationId": "{{communication id}}",
  "contactId": "{{your customer id}}",
  "environment": "production"
}'
```


#### Parameters

Parameter | Description
----------|------------
communicationId | The ID of the communication you want to send.
contactId | The ID of the contact you want to sent the message to.
environment | The environment to pick a template from. Either ‘draft’ or 'release’ at this point.
data | The data you want to use to send the message, this is optional when the contact already exists. If the contact exists and you provide a data object then it will update the contact.




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
