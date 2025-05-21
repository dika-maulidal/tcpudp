import socket

def start_tcp_server(host='127.0.0.1', port=12345):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"TCP Server listening on {host}:{port}")

    while True:
        client_socket, addr = server_socket.accept()
        print(f"Connected to {addr}")

        # Receive file name
        file_name = client_socket.recv(1024).decode()
        print(f"Receiving file: {file_name}")

        # Receive file content
        with open(f"received_tcp_{file_name}", 'wb') as f:
            while True:
                data = client_socket.recv(1024)
                if not data:
                    break
                f.write(data)

        print(f"File {file_name} received successfully")
        client_socket.close()

if __name__ == "__main__":
    start_tcp_server()