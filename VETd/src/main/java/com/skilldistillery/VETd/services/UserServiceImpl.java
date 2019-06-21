package com.skilldistillery.vetd.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.repositories.MenteeRepository;
import com.skilldistillery.vetd.repositories.MentorMenteeRepository;
import com.skilldistillery.vetd.repositories.MentorRepository;
import com.skilldistillery.vetd.repositories.ProfileRepository;
import com.skilldistillery.vetd.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository uRepo;
	@Autowired
	private MenteeRepository menteeRepo;
	@Autowired
	private MentorRepository mentorRepo;
	@Autowired
	private MentorMenteeRepository mmRepo;
	@Autowired
	private ProfileRepository pRepo;
	
	@Override
	public List<User> index() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<User> getAllUsers() {
		
		return uRepo.findAll();
	}


	@Override
	public Mentee getMenteeById(int id) {
		
		return menteeRepo.findMenteeById(id);
	}


	@Override
	public List<MentorMentee> getMentorsByMenteeId(int id) {
		return mmRepo.findByMenteeId(id);
	}


	@Override
	public List<MentorMentee> getMenteesByMentorId(int id) {
		return mmRepo.findByMentorId(id);
	}


	@Override
	public Mentee updateMentee(Mentee mentee, int id) {
		mentee.setId(id);
		
		menteeRepo.saveAndFlush(mentee);
		return mentee;
	}

	@Override
	public Mentor updateMentor(Mentor mentor, int id) {
		mentor.setId(id);
		mentorRepo.saveAndFlush(mentor);
		
		return mentor;
	}

	@Override
	public Object addJobstoMentee(List<Job> jobs, String username) {
		User user = uRepo.findUserByUsername(username);
		
		if(user.getProfile().getMentee() != null) {
			Mentee mentee =	user.getProfile().getMentee();
			for (Job job : jobs) {
				if(job == null) {
					continue;
				}
				mentee.addJob(job);
			}
			System.out.println(mentee);
			menteeRepo.saveAndFlush(mentee);
			return mentee;
			
		}else {
			Mentor mentor = user.getProfile().getMentor();
			for (Job job : jobs) {
				if(job == null) {
					continue;
				}
				mentor.addJob(job);
			}
			System.out.println(mentor);
			mentorRepo.saveAndFlush(mentor);
			return mentor;
		}
	}

	@Override
	public Mentee removeJobsFromMentee(List<Job> jobs, int id) {
		Mentee mentee = menteeRepo.findMenteeById(id);
		for (Job job : jobs) {
			mentee.removeJob(job);
		}
		return mentee;
	}


	@Override
	public Profile getProfileById(int id) {
		
		return pRepo.findProfileById(id);
	}

}
