vcl 4.0;

import std;

# Default backend definition. Set this to point to your content server.
backend default {
        .host = "www.frobware.com";
        .port = "80";
}

sub vcl_recv {
        if (req.url ~ "\.deb$") {
                unset req.http.Cookie;
                return (hash);
        }
        return (pass);
}

sub vcl_backend_response {
        if (bereq.url ~ "\.deb$") {
                unset beresp.http.set-cookie;
                set beresp.ttl = 1h;
        }
}

sub vcl_deliver {
        if (obj.hits > 0) {
                std.syslog(0, "Cache HIT");
                set resp.http.X-Cache = "HIT";
        } else {
                set resp.http.X-Cache = "MISS";
        }
}
