package com.skilldistillery.vetd.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost:4202" })
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
	//Update mentee
	@PutMapping("mentee/{id}")
	public Mentee updateMentee(@RequestBody Mentee mentee, @PathVariable int id) {
			return svc.updateMentee(mentee, id);
	}
	//Update mentor
	@PutMapping("mentor/{id}")
	public Mentor updateMentor(@RequestBody Mentor mentor, @PathVariable int id) {
		return svc.updateMentor(mentor, id);
	}
	//Add Job to Mentee
	@PutMapping("mentee/add/jobs")
	public Profile addJobsToMentee(@RequestBody List<Job> jobs, Principal principal) {
		System.out.println(jobs);
		System.out.println(principal.getName());
		return svc.addJobstoMentee(jobs, principal.getName());
	}
	//Remove Job from mentee
	@PutMapping("mentee/remove/jobs")
	public void removeJobsToMentee(@RequestBody List<Job> jobs, @PathVariable int id) {
		svc.removeJobsFromMentee(jobs, id);
	}
	@GetMapping("profile")
	public Profile getProfile(Principal p, HttpServletResponse response) {
		System.out.println(p.getName());
		return svc.getProfile(p.getName());
	}
	
}
