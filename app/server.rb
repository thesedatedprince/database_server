require 'socket'
require 'uri'
require_relative 'query_processor'

WEB_ROOT = 'app/views'

CONTENT_MAPPING = {
    'html' => 'text/html',
    'txt' => 'text/plain',
    'erb' => 'text/html'
}

DEFAULT_CONTENT_TYPE = 'application/octet-stream'

def content_type(path)
    ext = File.extname(path).split(".").last
    CONTENT_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
end

def requested_file(request_line)
    request_uri = request_line.split(" ")[1]
    path = URI.unescape(URI(request_uri).path)
    File.join(WEB_ROOT, path)
end

server = TCPServer.new('localhost',4000)
STDERR.puts "MattServer is open for business"

loop{
    socket = server.accept
    request_line = socket.gets

    STDERR.puts request_line

    path = requested_file(request_line)

    path = File.join(path, 'index.html') if File.directory?(path)

    if File.exist?(path) && !File.directory?(path)
        File.open(path, "rb") do |file|
            socket.print "HTTP/1.1 200 OK\r\n" + "Content-Type: #{content_type(file)}\r\n" +
            "Content-Length: #{file.size}\r\n" +
            "Connection: close\r\n"
            socket.print "\r\n"
            IO.copy_stream(file, socket)
        end
    else
        message = "File not found\n"
        socket.print "HTTP/1.1 404 Not Found\r\n" + "Content-Type: text/plain\r\n" +
        "Content-Length: #{message.size}\r\n" + "Connection: close\r\n"
        socket.print "\r\n"
        socket.print message
    end
    socket.close
}
