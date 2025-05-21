import socket
import sys
import os
import time

def start_udp_client(file_path, host='127.0.0.1', port=12345):
    # Check if file exists
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' not found")
        return

    # Get file size
    file_size = os.path.getsize(file_path)
    
    # Start timing
    start_time = time.time()

    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.settimeout(1.0)

    # Read file and prepare packets
    file_name = os.path.basename(file_path)
    with open(file_path, 'rb') as f:
        data = f.read()
    
    packet_size = 1000  # Data per packet (excluding header)
    packets = [data[i:i+packet_size] for i in range(0, len(data), packet_size)]
    
    # Send initialization packet
    init_packet = f"INIT:{file_name}:{len(packets)}".encode()
    client_socket.sendto(init_packet, (host, port))
    
    # Wait for ACK for init packet
    try:
        client_socket.recvfrom(1024)
    except socket.timeout:
        print("No ACK received for init packet")
        client_socket.close()
        return

    # Send data packets
    bytes_sent = 0
    for i, packet in enumerate(packets):
        # Add packet number as 4-byte header
        packet_data = i.to_bytes(4, 'big') + packet
        retries = 3
        while retries > 0:
            client_socket.sendto(packet_data, (host, port))
            try:
                client_socket.recvfrom(1024)
                bytes_sent += len(packet)
                break
            except socket.timeout:
                retries -= 1
                print(f"Retrying packet {i} ({retries} retries left)")
        if retries == 0:
            print(f"Failed to send packet {i} after retries")
            client_socket.close()
            return

    # Calculate transfer time and speed
    end_time = time.time()
    transfer_time = end_time - start_time
    speed_mbps = (file_size * 8 / 1_000_000) / transfer_time if transfer_time > 0 else 0

    # Print transfer information
    print(f"\nFile Transfer Summary:")
    print(f"File: {file_name}")
    print(f"Size: {file_size / 1024:.2f} KB ({file_size} bytes)")
    print(f"Time taken: {transfer_time:.3f} seconds")
    print(f"Transfer speed: {speed_mbps:.3f} Mbps")
    
    client_socket.close()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python udp_client.py <file_path>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    start_udp_client(file_path)