package com.skilldistillery.vetd.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class UserController {

	@Autowired
	private UserService svc;
	
	
	@GetMapping("users")
	public List<User> getAllUsers(){
		return svc.getAllUsers();
	}
	@GetMapping("mentee/{id}")
	public Mentee getMenteeById(@PathVariable int id){
		
		return svc.getMenteeById(id);
	}
	//Get list of Mentors for mentee by Id
	@GetMapping("mentee/{id}/mentor")
	public List<MentorMentee> getMentorsByMenteeId(@PathVariable int id){
		return svc.getMentorsByMenteeId(id);
	}
	//Get list of Mentees for mentor by Id
	@GetMapping("mentor/{id}/mentee")
	public List<MentorMentee> getMenteesByMentorId(@PathVariable int id){
		return svc.getMenteesByMentorId(id);
	}
	
}
