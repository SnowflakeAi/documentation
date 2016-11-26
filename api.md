Developer API
================

Welcome to the Snowflake API.

Authentication
--------------

Almost all calls to the Snowflake API require you to authenticate yourself to ensure no unauthorised requests are being made. We use API keys to allow access, you can create a new API keys from the Snowflake UI.

> Curl example
```
curl "{{api endpoint}}" \
-H "Content-Type: application/json"
-H "Authorization: Bearer {{api key}}"
```

Errors
------

The Snowflake API uses the following error codes:

Error|Code|Meaning
-----|----|-------
400 | Bad Request | Your request is invalid
401 | Unauthorized | Your API key is wrong
403 | Forbidden | You do not have access to the current resource
404 | Not Found | The specified resource could not be found
405 | Method Not Allowed | You tried to access a resource with an invalid method
429 | Too Many Requests | You are exceeding our rate limits.
500 | Internal Server Error | We had a problem with our server. Try again later.
503 | Service Unavailable | We’re temporarially offline for maintanance. Please try again later.
