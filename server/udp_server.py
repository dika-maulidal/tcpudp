import socket

def start_udp_server(host='127.0.0.1', port=12345):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    server_socket.bind((host, port))
    print(f"UDP Server listening on {host}:{port}")

    # Buffer to store file data
    file_data = {}
    expected_packets = 0
    received_packets = 0

    while True:
        data, addr = server_socket.recvfrom(1024)
        
        # First packet contains file name and packet count
        if data.startswith(b'INIT:'):
            file_name, packet_count = data[5:].decode().split(':')
            expected_packets = int(packet_count)
            file_data = {}
            received_packets = 0
            server_socket.sendto(b'ACK', addr)
            print(f"Receiving file: {file_name} ({expected_packets} packets)")
            continue

        # Regular data packet
        packet_num = int.from_bytes(data[:4], 'big')
        file_data[packet_num] = data[4:]
        received_packets += 1
        server_socket.sendto(b'ACK', addr)

        # Check if all packets received
        if received_packets == expected_packets:
            with open(f"received_udp_{file_name}", 'wb') as f:
                for i in range(expected_packets):
                    if i in file_data:
                        f.write(file_data[i])
            print(f"File {file_name} received successfully")
            break

if __name__ == "__main__":
    start_udp_server()