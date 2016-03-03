# WEBSERVER_HANDLER
---
# WEBSERVER_HANDLER

## Summary

 * What?
 * Why?
 * How?
 * Demo!
 * What's next?

---
# WEBSERVER_HANDLER - What?
---
# WEBSERVER_HANDLER
## What ?

WEBSERVER class has different handlers ( /texture, /configuration, ... )
 

Was defined with a table of ENTRY

    !c++
    struct ENTRY
    {
        PRIMITIVE_TEXT
            Uri,
            Description;
        CALLABLE_RESULT_METHOD_1_OF_< BOOL, REQUEST >
            BeginRequestCallback;
        CALLABLE_RESULT_METHOD_1_OF_< BOOL, REQUEST >
            WebsocketDataCallback;
    };

WEBSERVER_HANDLER will be a base class for all handlers, ENTRY struct not needed anymore.
WEBSERVER_HANDLER will be compatible with Websocket connections.

---
# WEBSERVER_HANDLER - Why?
---
# WEBSERVER_HANDLER
## Why ?

Previous way to add a web handler :

    !c++
    WEBSERVER::AddHandler(
        "interface", // Uri on server (http://localhost/xxxx)
        WEBSERVER_INTERFACE::GetInstance(),
        & WEBSERVER_INTERFACE::Handle, // Callback to handle requests
        "Interface" // Displayed name on index page
        );


---
# WEBSERVER_HANDLER
## Why ?

Websockets need another callback :

    !c++
    WEBSERVER::AddHandler(
        "interface",
        WEBSERVER_INTERFACE::GetInstance(),
        & WEBSERVER_INTERFACE::Handle,
        & WEBSERVER_INTERFACE::OtherCallback, // Another callback
        "Interface"
        );

  * Have to write another line
  * WEBSERVER::AddHandler could be overridden -> more code again

---
# WEBSERVER_HANDLER
## Why ?

A table of active connections will be useful for Websockets:

    !c++
    WEBSERVER::AddHandler(
        "interface",
        WEBSERVER_INTERFACE::GetInstance(),
        & WEBSERVER_INTERFACE::Handle,
        & WEBSERVER_INTERFACE::OtherCallback,
        & ConnectionTable, // Pointer to a table
        "Interface"
        );

  * Too much lines of code to write
  * Giving a pointer to the table is not a sexy solution



---
# WEBSERVER_HANDLER
## Why ?

So here is the new base class

    !c++
    class WEBSERVER_HANDLER
    {
        // ...

        // .. ATTRIBUTES

        PRIMITIVE_TEXT
            Uri,
            Description;
        PRIMITIVE_ARRAY_OF_< WEBSERVER_REQUEST >
            ActiveConnectionTable;
    };


---
# WEBSERVER_HANDLER - How?
---
# WEBSERVER_HANDLER
## How ?

Create your WEBSERVER_HANDLER_SOMETHING class :

  * Derives from WEBSERVER_HANDLER
  * Sets Uri and Description attributes (used in Mojito Index Page)
  * Call WEBSERVER_HANDLER::Register()


---
# WEBSERVER_HANDLER
## How ?

Override this method for normal web requests :

    !c++
    virtual REQUEST_RESPONSE OnRequest(
        WEBSERVER_REQUEST & request
        );

It quite the same as before :

    !c++
    BOOL Handle(
        WEBSERVER_REQUEST & request
        );

---
# WEBSERVER_HANDLER
## How ?

Response can be :

    !c++
    enum REQUEST_RESPONSE
    {
        REQUEST_RESPONSE_Processed = MG_REQUEST_PROCESSED,
        REQUEST_RESPONSE_NotProcessed = MG_REQUEST_NOT_PROCESSED
    };


---
# WEBSERVER_HANDLER
## How ?

Override this method for websocket data requests :

    !c++
    virtual WEBSOCKET_RESPONSE OnWebsocketData(
        WEBSERVER_REQUEST & request
        );

Response can be :

    !c++
    enum WEBSOCKET_RESPONSE
    {
        WEBSOCKET_RESPONSE_Continue = MG_CLIENT_CONTINUE,
        WEBSOCKET_RESPONSE_Close = MG_CLIENT_CLOSE
    };

---
# WEBSERVER_HANDLER
## How ?

Send Websocket data to clients :

    !c++
    PARALLEL_SECTION_Begin( WEBSERVER::ActiveConnectionTableAtomicity )
    {
        PRIMITIVE_ForEachTableItem( WEBSERVER_REQUEST & request, ActiveConnectionTable )
        {
            request.WriteWebsocketText( line );
        }
    }

Parallel section is required since ActiveConnectionTable is filled in another thread by Mongoose.

The way to iterate ActiveConnectionTable may be replaced by a callback,
so ActiveConnectionTable would be private.

---
# WEBSERVER_HANDLER - Demo!

---
# WEBSERVER_HANDLER - What's next?

---
# WEBSERVER_HANDLER
## What's next?

  * A transparent way to send data through websockets (callback)

  * A summary text attribute that would be displayed on Mojito Index Page

    * g.e : Texture viewer (42 textures loaded, 20480 KiB used)

  * More handlers with persistent connections thanks to websockets!

---
# WEBSERVER_HANDLER - The End

<center>
For Fishing Cactus,<br/>
by Gauthier Billot <br/>
< gauthier.billot @ fishingcactus.com >
</center>