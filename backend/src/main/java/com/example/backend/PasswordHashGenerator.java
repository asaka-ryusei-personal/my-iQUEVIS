package com.example.backend;

import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;

public class PasswordHashGenerator {

	public static void main(String[] args) {
		if (args.length < 1) {
			System.out.println("Usage: ./gradlew run --args='<password>'");
			System.out.println("If you use cmd...");
			System.out.println("Usage: gradlew run --args='<password>'");
			System.exit(1);
		}

		String rawPassword = args[0];

		Argon2PasswordEncoder encoder = new Argon2PasswordEncoder(
				16, 32, 1, 1 << 12, 3);

		String hashed = encoder.encode(rawPassword);

		System.out.println("password: " + rawPassword);
		System.out.println("hashed: " + hashed);
	}
}
