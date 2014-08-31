import Foundation

var sockfd: Int32
sockfd = -1
// デフォルトは80
var port = (C_ARGC == 2) ? atoi(C_ARGV[1]) : 80

// socket作成
sockfd = socket(AF_INET, SOCK_STREAM, 0)
if sockfd < 0 {
	perror("socket")
	exit(EXIT_FAILURE)
}

// Port, IPアドレスを設定(IPv4)
memset(&server, 0, sizeof(server))
server.sin_family = AF_INET
server.sin_addr.s_addr = INADDR_ANY
//server.sin_port = htons(port)

// socketをすぐ再利用できるように
char opt = 1;
var flag: Int32 = 1
var len  = socklen_t(sizeof(Int32))
setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &flag, len)

var addr = sockaddr(addrIn)
 
// ディスクリプタとPortを結び付ける
error = bind(serverSocket, &addr, len)
if error < 0 {
    println("failed to bind. code = \(error)")
    close(serverSocket)
    return
}

// listen準備
if (listen(sockfd, SOMAXCONN) < 0) {
    perror("listen");
    exit(EXIT_FAILURE);
}

// メインループ
