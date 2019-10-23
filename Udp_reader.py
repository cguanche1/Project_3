
import socket

UDP_IP = "198.168.1.2"
UDP_PORT = 57222

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

sock.bind((UDP_IP,UDP_PORT))

while True:
	data, addr = sock.recvfrom(1024)
	print ("received message: {}", .fortmat(data))