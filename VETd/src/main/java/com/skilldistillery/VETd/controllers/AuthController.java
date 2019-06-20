package com.skilldistillery.vetd.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.services.AuthService;
import com.skilldistillery.vetd.entities.User;

@RestController
@CrossOrigin({"*", "http://localhost:4201"})
public class AuthController {

	@Autowired
	private AuthService svc;
	
	@PostMapping("/register")
	public User register(@RequestBody User user, HttpServletResponse res) {
	    if (user == null) {
	        res.setStatus(400);
	    }
	    	System.out.println(user);
	    user = svc.register(user);

	    return user;
	}

	@GetMapping("/authenticate")
	public Principal authenticate(Principal principal) {
		System.out.println("AUTHENTICATING");
	    return principal;
	}
}
