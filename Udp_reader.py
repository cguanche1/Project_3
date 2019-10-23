
import socket

UDP_IP = "192.168.1.2"
UDP_PORT = 57222

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

sock.bind((UDP_IP,UDP_PORT))

while True:
	print("----------------")
	data, addr = sock.recvfrom(2048)
	print ("received message: ", data)