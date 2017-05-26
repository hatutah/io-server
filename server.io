#!/usr/bin/env io

WebRequest := Object clone do(
    handleSocket := method(socket, server,
        socket streamReadNextChunk
        if(socket isOpen == false, return)
        request := socket readBuffer betweenSeq("GET ", " HTTP")
        socket streamWrite("HTTP/1.0 200 OK\n\n")
        socket streamWrite(Random value)
        socket close
    )
)

WebServer := Server clone do(
    setPort(8080)
    handleSocket := method(aSocket,
        WebRequest clone asyncSend(handleSocket(aSocket))
    )
) start

WebServer start
