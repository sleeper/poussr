Poussr
==========

Poussr is a small Sinatra application, that allows for dispatching information to 
browsers through WebSocket.

It is loosely designed after [Pusher](http://pusherapp.com), but far less powerfull.
In fact it suits exactly (or will when terminated) my very own needs.

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


Design
=========
