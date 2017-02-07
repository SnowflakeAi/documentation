Data Integration API
--------------------

This is the API endpoint that you would use to synchronize your data between your internal solutions and the Snowflake service.

## Schema validation

In order to use the customer data inside Snowflake you will need to create a schema to describe the customer data, this is normally only needed once (or whenever the data structure changes). The benefit of having this is that you basically tell the Snowflake solution what the data is, so in turn Snowflake can help your marketing and/or communication person create their own segments and templates without needing technical help.

Now in order to get started you do not need to complete this schema, it just needs to exist. By default the schema for the main collection "recipient" already exists, but if you want to synchronize other collections like "product" then you will first need to create this schema in the Snowflake UI under [Admin Dashboard](https://everyone.likesneon.com/#/admin/schemas).

Once you have defined your schema then it will also be used to validate the customer data that you are trying to synchronize and it will return the errors (if any) back as the response to the API call.


## Batch upload endpoint

There are two ways to synchronize a large number of contacts in one API call. The first is to upload a file containing the customer data in JSON format and the other is to PUT the data to this same endpoint. The data structure is exactly the same in both cases. The main collection "recipients" needs to be the same as the collection name used in the URL minus the "s".

```
{
  "recipients": [
    {
      "id": "your unique internal id",
      "other": "properties",
      "which": {
        "can": "be",
        "another": "object"
      },
      "or": [
        {
          "an": "array",
          "with": "objects"
        },
        { .. }
      ]
    },
    { .. }
  ]
}
```

As you can see you are completely flexible to create the data structure you need, most often it serves as a good start to use the identical strcture your internal solution have, but in many cases it makes sence to add soem structure. F.ex. instead of a flat list that contains the customer name, address and contact details it may make more sense to create a customer object with the customer name that again contains an address object containing the address. This is becasue this is the structure that will be presented to the people using the Snowflake UI.

The only property that is mandatory inside each collection item is "id" and this needs to be a string and should be unique in that collection.


### Upload a file method

This is mostly a convenient method so you can easily test the content of your JSON customer structure.

```
curl "https://webhuset.likesneon.com/api/data/recipient/batch"
  -X PUT
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
  -H "Cache-Control: no-cache"
  -F "filename=data.json"
  -F "file=@./path/to/the/file/to/upload.json"  
```

### Put the data in the request body yourself

```
curl "https://webhuset.likesneon.com/api/data/recipient/batch"
  -X PUT
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
  -d '{
  "recipients": [
    {
      "id": "your unique internal id",
      "other": "properties",
      "which": {
        "can": "be",
        "another": "object"
      },
      "or": [
        {
          "an": "array",
          "with": "objects"
        },
        { .. }
      ]
    },
    { .. }
  ]
}'
```

### Success

The call can be successful and still there may be validation errors in some objects. If this is the case than they will be returned in the request body as well. If there are no validation errors then the errors array will be empty. The reply will almost always contain a receipt about what has happened (not available if no schema is found), this is useful to verify agains with what you expected to happen. Objects that you upload/post are always overriding existing objects. If you need to mutate data then you should first retrieve the object from Snowflake with a `GET` request (shown below here), do the mutation yourself and then upload/post the new object. 

```
{
  "processing_results" : {
    "updated" : 49,
    "unchanged" : 22186,
    "invalid" : 412,
    "inserted" : 20
  },
  "errors" : [
    {
      "item" : {
        "customer" : {
          "name" : "Mark Nijhof",
          "email" : "mark@snowflake.ai--"
        },
        "id" : "30780"
      },
      "error" : [
        "Expected \"mark@snowflake.ai--\" to be an email address. For property #/customer/email"
      ]
    }
  ]
}
```

## Get all object IDs

In order to know what contacts and/or other objects are stored in Snowflake you may request all IDs using the following `GET` request.

```
curl "https://webhuset.likesneon.com/api/data/recipient"
  -X GET
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
```

### Success

When sucessful you will receive an array with IDs.

```
{
  "recipients" : [
    "id-1",
    "id-2",
    "id-3",
    ...
  ]
}
```

## Get a specific object

You may also retrieve a single specific object from Snowflake using the following `GET` request where `{{id}}` is replaced by the ID of the object:

```
curl "https://webhuset.likesneon.com/api/data/recipient/{{id}}"
  -X GET
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
```

### Success

When sucessful you will receive the complete object, snowflake also stores meta data for each object like "opens" and "clicks", this is intentionally not returned to preserve this information.

```
{
  "id": "your unique internal id",
  "other": "properties",
  "which": {
    "can": "be",
    "another": "object"
  },
  "or": [
    {
      "an": "array",
      "with": "objects"
    },
    { .. }
  ]
}
```

## Update a specific object

You may also update a single specific object from Snowflake using the following `PUT` request. It is important that the ID of the object you want to update is in the data itself:

```
curl "https://webhuset.likesneon.com/api/data/recipient"
  -X PUT
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
  -d '{
  "id": "your unique internal id",
  "other": "properties",
  "which": {
    "can": "be",
    "another": "object"
  },
  "or": [
    {
      "an": "array",
      "with": "objects"
    },
    { .. }
  ]
}'
```

### Success

When the call is successful you can expect the same reply as when making a batch call.

```
{
  "processing_results" : {
    "updated" : 1,
    "unchanged" : 0,
    "invalid" : 0,
    "inserted" : 0
  },
  "errors" : [
  ]
}
```

## Delete a specific object

You may also delete a single specific object from Snowflake using the following `DELETE` request where `{{id}}` is replaced by the ID of the object:

```
curl "https://webhuset.likesneon.com/api/data/recipient/{{id}}"
  -X DELETE
  -H "Content-Type: application/json"
  -H "Authorization: Bearer {{your api key}}"
```

### Success

When a `DELETE` request is successful you will only get a status `200 OK` back.

