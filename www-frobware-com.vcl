vcl 4.0;

backend default {
        .host = "www.frobware.com";
        .port = "80";
}

sub vcl_recv {
        if (req.url ~ ".deb$") {
                unset req.http.Cookie;
        }
        return (hash);
}

sub vcl_backend_response {
        # Happens after we have read the response headers from the backend.
        #
        # Here you clean the response headers, removing silly Set-Cookie headers
        # and other mistakes your backend does.
}

sub vcl_deliver {
        # Happens when we have all the pieces we need, and are about to send the
        # response to the client.
        #
        # You can do accounting or modifying the final object here.
}
