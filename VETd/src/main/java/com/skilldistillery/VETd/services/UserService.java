package com.skilldistillery.vetd.services;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
<<<<<<< HEAD
=======
import com.skilldistillery.vetd.entities.Message;
>>>>>>> eadddf7d5bb01b8c4dbc7421cffec8e83912860f
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.Review;
import com.skilldistillery.vetd.entities.User;

public interface UserService {

	public List<User> index();

	public List<User> getAllUsers();

	public Mentee getMenteeById(int id);

	public Set<Profile> getMentorsByMenteeUsername(String name);

	public Set<Profile> getMenteesByMentorUsername(String name);

	public Profile updateMentee(Profile profile);

	public Profile addJobstoMentee(Collection<Job> jobs, String username);

	public Profile removeJobsFromMentee(Job job, String name);

	public Profile getProfileById(int id);

	public Profile getProfile(String name);

	public List<User> getUsersByUsername(String name);

	public Set<Profile> getMenteesWithJobs(String name);

	public Set<Profile> addMenteeToMentorList(Profile profile, String name);

	public void removeMenteeFromMentorList(Profile profile, String name);
	
	public Set<Review> getReviewsByProfileId(String name);
<<<<<<< HEAD

=======
	
	public Review addReview(Profile profile);

	public Object addMessage(Message message, String name);
>>>>>>> eadddf7d5bb01b8c4dbc7421cffec8e83912860f
}
