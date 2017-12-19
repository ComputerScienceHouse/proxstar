from websockify.websocket import *
from websockify.websocketproxy import *

server = WebSocketProxy(listen_port='10000', target_port='6000')
server.start_server()
