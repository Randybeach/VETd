package com.skilldistillery.vetd.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.services.AuthService;

@RestController
@CrossOrigin({"*", "http://localhost:4202"})
public class AuthController {

	@Autowired
	private AuthService svc;
	
	@PostMapping("/register/mentee")
	public Mentee registerMentee(@RequestBody Profile profile, HttpServletResponse res) {
	    if (profile == null) {
	        res.setStatus(400);
	    }
	    Mentee mentee = new Mentee();
	    mentee.setProfile(profile);
	    mentee = svc.registerMentee(mentee);
	    System.out.println(mentee);

	    return mentee;
	}
	@PostMapping("/register/mentor")
	public Mentor registerMentor(@RequestBody Profile profile, HttpServletResponse res) {
		if (profile == null) {
			res.setStatus(400);
		}
		Mentor mentor = new Mentor();
		mentor.setProfile(profile);
		mentor = svc.registerMentor(mentor);
		
		return mentor;
	}

	@GetMapping("/authenticate")
	public Principal authenticate(Principal principal) {
		System.out.println("AUTHENTICATING");
	    return principal;
	}
	@PostMapping("/register")
	public User registerUser(@RequestBody User user) {
		return svc.register(user);
	}
}
