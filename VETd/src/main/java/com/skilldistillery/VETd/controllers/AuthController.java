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
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.services.AuthService;

@RestController
@CrossOrigin({"*", "http://localhost:4202"})
public class AuthController {

	@Autowired
	private AuthService svc;
	
	@PostMapping("/register/mentee")
	public Mentee registerMentee(@RequestBody Mentee mentee, HttpServletResponse res) {
	    if (mentee == null) {
	        res.setStatus(400);
	    }
	    	System.out.println(mentee);
	    mentee = svc.registerMentee(mentee);

	    return mentee;
	}
	@PostMapping("/register/mentor")
	public Mentor registerMentor(@RequestBody Mentor mentor, HttpServletResponse res) {
		if (mentor == null) {
			res.setStatus(400);
		}
		System.out.println(mentor);
		mentor = svc.registerMentor(mentor);
		
		return mentor;
	}

	@GetMapping("/authenticate")
	public Principal authenticate(Principal principal) {
		System.out.println("AUTHENTICATING");
	    return principal;
	}
}
