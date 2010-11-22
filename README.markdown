Poussr
==========

Poussr is a small Sinatra application, that allows for dispatching information to 
browsers through WebSocket.

It is loosely designed after [Pusher](http://pusherapp.com), but far more powerfull.
In fact it suits exactly (or will when terminated) my very own needs.

Communication between the browser and Poussr is done over a WebSocket
connection, through the concept of a channel: when connecting to the
server the client (browser) ask for a specific channel. All the
message broadcasted on this channel will then be delivered to all
clients associted with this channel.


Setup
=========


Design
=========
