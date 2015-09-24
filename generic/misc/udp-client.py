import socket
import sys
import time

# create dgram udp socket
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
except socket.error:
    print 'Failed to create socket'
    sys.exit()

host = 'localhost';
port = 8888;

sndbuf = s.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)
print 'old SOCK_SNDBUF =', sndbuf

#s.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1)

#sndbuf = s.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)
#print 'new SOCK_SNDBUF =', sndbuf

while(1) :
    msg = 'x' * 1500

    try :
        #Set the whole string
        s.sendto(msg, (host, port))
        time.sleep(1)

        """
        # receive data from client (data, addr)
        d = s.recvfrom(65535)
        reply = d[0]
        addr = d[1]

        print 'Server reply : ' + str(len(reply))
        """

    except socket.error, msg:
        print 'Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
        sys.exit()
