Poussr
==========

Poussr is a (small) Sinatra application, that allows for dispatching information to 
browsers through WebSocket.

It is loosely designed after [Pusher](http://pusherapp.com), but far less powerfull.
In fact it suits exactly (or will when terminated) my very own needs
(which were light but constrained by the fact that the application
that is going to use Poussr will potentially not have access to the Net).

Whereas Pusher is allowing to have several channel multiplexed over a
websocket connection (and several event multiplexed over each
channel), Poussr takes a lazier path, and only offers to convey
information of one given channel per websocket.

When connecting to Poussr, the browser subscribe to a given channel:
all the message sent to this channel will then be sent to the browser.
The javascript code can also subscribe to the events sent on the
channel, and callbacks will be called based on this subscription.


Setup
=========


Protocol
=========

From client to Poussr
---------------------

To send a new event on a given channel to Poussr, client must call a
REST API:

    POST http://<your Poussr address>/v1/channels/<channel>/events?name=<event_name>

Data of the event is transmitted in the body of the POST.

For example, to send the event 'newuser', on channel 'users', with
data {'name': "Fred"}, on localhost, you can use the following curl
call:

    curl -X 'POST' -d "{'name': 'Fred'}" http://127.0.0.1/v1/channels/users/events?name=newuser


From browser to Poussr
----------------------

When the browser's client is connected, through WebSocket, it sends a
subscription event, with channel name as data:

    poussr:subscribe / {'channel': "channel name"}

The client can then subscribe to the event that interest it, using the
'subscribe' method.

    mypoussrobj.subscribe('event:tofollow', function(data) { /* the callback */ });


Design
=========
