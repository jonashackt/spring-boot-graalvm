package io.jonashackt.springbootgraal;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.reactive.server.WebTestClient;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class HelloRouterTest {

	@Test void
	should_call_reactive_rest_resource(@Autowired WebTestClient webTestClient) {
		webTestClient.get().uri("/hello")
			.accept(MediaType.TEXT_PLAIN)
			.exchange()
			.expectBody(String.class).isEqualTo(HelloHandler.RESPONSE_TEXT);
	}
}
