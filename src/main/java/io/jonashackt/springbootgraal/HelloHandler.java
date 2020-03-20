package io.jonashackt.springbootgraal;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

@Component
public class HelloHandler {

    protected static String RESPONSE_TEXT= "Hello Reactive People!";

    public Mono<ServerResponse> hello(ServerRequest serverRequest) {
        return ServerResponse
                        .ok()
                        .contentType(MediaType.TEXT_PLAIN)
                        .body(BodyInserters.fromValue(RESPONSE_TEXT));
    }
}
