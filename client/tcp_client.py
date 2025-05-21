import socket
import sys
import os
import time

def start_tcp_client(file_path, host='127.0.0.1', port=12345):
    # Check if file exists
    if not os.path.exists(file_path):
        print(f"Error: File '{file_path}' not found")
        return

    # Get file size
    file_size = os.path.getsize(file_path)
    
    # Start timing
    start_time = time.time()
    
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))

    # Send file name
    file_name = os.path.basename(file_path)
    client_socket.send(file_name.encode())

    # Send file content
    bytes_sent = 0
    with open(file_path, 'rb') as f:
        while True:
            data = f.read(1024)
            if not data:
                break
            client_socket.send(data)
            bytes_sent += len(data)

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
        print("Usage: python tcp_client.py <file_path>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    start_tcp_client(file_path)