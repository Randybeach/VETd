package com.skilldistillery.vetd.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Message;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.Review;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost:4202" })
public class UserController {

	@Autowired
	private UserService svc;

	@GetMapping("users")
	public List<User> getAllUsers() {
		return svc.getAllUsers();
	}

	@GetMapping("mentee/{id}")
	public Mentee getMenteeById(@PathVariable int id) {

		return svc.getMenteeById(id);
	}

	// Get list of Mentors for mentee by Id
	@GetMapping("mentee/{id}/mentor")
	public Set<Profile> getMentorsByMenteeId(Principal principal) {

		return svc.getMentorsByMenteeUsername(principal.getName());
	}

	// Get list of Mentees for mentor by Id
	@GetMapping("mentor/{id}/mentee")
	public Set<Profile> getMenteesByMentorId(Principal principal) {
		System.out.println(
				"************************** Mentees by mentor username *********************************************");
		return svc.getMenteesByMentorUsername(principal.getName());
	}

	@GetMapping("search/{name}")
	public List<User> getUsersByUsername(@PathVariable String name) {
		return svc.getUsersByUsername(name);
	}

	// Update Profile
	@PutMapping("profile")
	public Profile updateMentee(@RequestBody Profile profile) {
		System.out.println(" ^^^" + profile);
		return svc.updateMentee(profile);
	}

	// Add Job to Mentee
	@PutMapping("add/jobs")
	public Profile addJobsToMentee(@RequestBody List<Job> jobs, Principal principal) {
		return svc.addJobstoMentee(jobs, principal.getName());
	}

	// Remove Job from mentee
	@PutMapping("remove/jobs")
	public Profile removeJobsFromMentee(@RequestBody Job job, Principal p) {
		Profile po = svc.removeJobsFromMentee(job, p.getName());
		System.out.println(po.getMentee());
		return po;
	}

	@GetMapping("profile")
	public Profile getProfile(Principal p, HttpServletResponse response) {
		System.out.println(p.getName());
		return svc.getProfile(p.getName());
	}

	// Get a list of Mentees that desire mentorship for chosen jobs
	@GetMapping("mentee/job")
	public Set<Profile> getMenteesWithChosenJobs(Principal p) {
		return svc.getMenteesWithJobs(p.getName());
	}

	// Add a mentee to a mentors list
	@PutMapping("mentormentee")
	public Set<Profile> addMenteeToMentorshipList(@RequestBody Profile profile, Principal principal) {
		System.out.println("trying to add mentor mentee");
		return svc.addMenteeToMentorList(profile, principal.getName());
	}

	// Remove a mentee from mentors list
	@PutMapping("mentormentee/remove")
	public void removeMenteeFromMentorshipList(@RequestBody Profile profile, Principal principal) {
		System.out.println(profile);
		System.err.println(principal);
		svc.removeMenteeFromMentorList(profile, principal.getName());
	}

	//Get reviews by profile id
	@GetMapping("review")
	public Set<Review> getReviews(Principal principal) {
		return svc.getReviewsByProfileId(principal.getName());
	}
	
	// Add a message to mentor_mentee
	@PostMapping("message/{recipientId}")
	public void addMessage(@RequestBody Message message, Principal principal, @PathVariable int recipientId) {
		
		 svc.addMessage(message, principal.getName());
	}

	@PostMapping("review")
	public Review postNewReview(@RequestBody Review review, Principal principal) {
		return svc.postNewReview(review, principal.getName());
	}
}
