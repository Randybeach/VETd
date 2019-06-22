package com.skilldistillery.vetd.services;

import java.util.List;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.User;

public interface UserService {

	public List<User> index();

	public List<User> getAllUsers();

	public Mentee getMenteeById(int id);

	public List<MentorMentee> getMentorsByMenteeId(int id);

	public List<MentorMentee> getMenteesByMentorId(int id);

	public Mentee updateMentee(Mentee mentee, int id);

	public Mentor updateMentor(Mentor mentor, int id);

	public Object addJobstoMentee(List<Job> jobs, String username);

	public Mentee removeJobsFromMentee(List<Job> jobs, int id);

	public Profile getProfileById(int id);
}
