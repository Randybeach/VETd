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
import com.skilldistillery.vetd.repositories.JobRepository;
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
	@Autowired
	private JobRepository jRepo;

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
	public Profile updateMentee(Profile profile) {
		pRepo.saveAndFlush(profile);
		return profile;
	}


	@Override
	public Profile addJobstoMentee(List<Job> jobs, String username) {
		User user = uRepo.findUserByUsername(username);
		Profile p = user.getProfile();

		if (user.getProfile().getMentee() != null) {
			Mentee mentee = user.getProfile().getMentee();
			for (Job job : jobs) {
				if (job == null) {
					continue;
				}
				mentee.addJob(job);
			}
			System.out.println(mentee);
			menteeRepo.saveAndFlush(mentee);
			p.setMentee(mentee);
			return p;

		} else {
			Mentor mentor = user.getProfile().getMentor();
			for (Job job : jobs) {
				if (job == null) {
					continue;
				}
				mentor.addJob(job);
			}
			System.out.println(mentor);
			mentorRepo.saveAndFlush(mentor);
			p.setMentor(mentor);
			return p;
		}
	}

	@Override
	public Profile removeJobsFromMentee(Job job, String name) {
		job = jRepo.findById(job.getId()).get();
		User user = uRepo.findUserByUsername(name);
		Profile p = user.getProfile();
		System.out.println(p);
		if (user.getProfile().getMentee() != null) {
			Mentee mentee = user.getProfile().getMentee();
			mentee.removeJob(job);

			System.out.println(mentee);
			menteeRepo.saveAndFlush(mentee);
			p.setMentee(mentee);
			pRepo.saveAndFlush(p);
			System.out.println(p.getMentee().getJobs());
			return p;
		} else {
			Mentor mentor = user.getProfile().getMentor();

			mentor.removeJob(job);

			System.out.println(mentor);
			mentorRepo.saveAndFlush(mentor);
			p.setMentor(mentor);
			return p;
		}

	}

	@Override
	public Profile getProfileById(int id) {

		return pRepo.findProfileById(id);
	}

	@Override
	public Profile getProfile(String name) {
		return pRepo.findByUser_Username(name);
	}

	@Override
	public List<User> getUsersByUsername(String name) {
		name = "%" + name + "%";
		return uRepo.findUserByUsernameLike(name);
	}

}
