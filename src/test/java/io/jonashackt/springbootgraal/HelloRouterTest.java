package io.jonashackt.springbootgraal;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import static org.junit.jupiter.api.Assertions.assertEquals;

@ExtendWith(SpringExtension.class)
@SpringBootTest(
		webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT
)
class HelloRouterTest {

	@LocalServerPort
	private int port;

	private WebClient webClient;

	@BeforeEach
	public void init() {
		webClient = WebClient.create("http://localhost:" + port);
	}

	@Test void
	should_call_reactive_rest_resource() {
		Mono<ClientResponse> result = webClient
				.get()
				.uri("/hello")
				.accept(MediaType.TEXT_PLAIN)
				.exchange();

		assertEquals(HelloHandler.RESPONSE_TEXT, result.flatMap(response -> response.bodyToMono(String.class)).block());
	}

}
