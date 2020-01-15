package com.shopmvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ShopMvcApplication {

	public static void main(String[] args) {
		SpringApplication.run(ShopMvcApplication.class, args);
		System.out.println("It's running!!! Lucky for you!");
	}
}
