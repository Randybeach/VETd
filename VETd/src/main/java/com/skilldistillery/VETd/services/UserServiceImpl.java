package com.skilldistillery.vetd.services;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.repositories.JobRepository;
import com.skilldistillery.vetd.repositories.LocationRepository;
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
	@Autowired
	private LocationRepository lRepo;

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
	public Set<Profile> getMentorsByMenteeId(int id) {
		System.out.println("********************" + mmRepo.findByMenteeId(id));
		Set<MentorMentee> mentors = new HashSet<MentorMentee>();
		Set<Profile> mentorProfiles = new HashSet<Profile>();
		mentors = mmRepo.findByMentorId(id);
		for (MentorMentee mm : mentors) {
			mentorProfiles.add(pRepo.findByMentorId(mm.getId()));
			System.out.println("***************** Adding mentor profiles");
			System.out.println("***************** Adding mentor profiles");
			System.out.println("***************** Adding mentor profiles");
		}
		return mentorProfiles;
	}

	@Override
	public Set<Profile> getMenteesByMentorId(int id) {
		System.out.println("***************************" + mmRepo.findByMentorId(id));
		Set<MentorMentee> mentees = new HashSet<MentorMentee>();
		Set<Profile> menteeProfiles = new HashSet<Profile>();
		mentees = mmRepo.findByMentorId(id);
		for (MentorMentee mm : mentees) {
			menteeProfiles.add(pRepo.findByMenteeId(mm.getMentee().getId()));
			System.out.println("***************** Adding mentee profiles");
			System.out.println("***************** Adding mentee profiles" + mm.getMentee().getId());
			System.out.println("***************** Adding mentee profiles");
			System.out.println("***************** Adding mentee profiles");
		}
		return menteeProfiles;
	}

	@Override
	public Profile updateMentee(Profile profile) {
		System.out.println(profile);
		
		if(profile.getMentee() != null) {
			profile.getMentee().setProfile(profile);
			pRepo.saveAndFlush(profile);
			menteeRepo.saveAndFlush(profile.getMentee());
			if(profile.getMentee().getJobs() != null) {
				Collection<Job> jobs = profile.getMentee().getJobs();
				for (Job job : jobs) {
					profile = this.removeJobsFromMentee(job, profile.getUser().getUsername());
				}
				profile = this.addJobstoMentee(jobs, profile.getUser().getUsername());
			}
			
			
		}else {
			profile.getMentor().setProfile(profile);
			pRepo.saveAndFlush(profile);
			mentorRepo.saveAndFlush(profile.getMentor());
			if(profile.getMentor().getJobs() != null) {
				Collection<Job> jobs = profile.getMentor().getJobs();
				for(Job job : jobs) {
					profile = this.removeJobsFromMentee(job, profile.getUser().getUsername());
				}
				profile = this.addJobstoMentee(jobs, profile.getUser().getUsername()); 
			}
			
		}
		lRepo.saveAndFlush(profile.getLocation());
		uRepo.saveAndFlush(profile.getUser());
		System.out.println("* " + profile);
		
		return profile;
	}


	@Override
	public Profile addJobstoMentee(Collection<Job> jobs, String username) {
		
		User user = uRepo.findUserByUsername(username);
		Profile p = user.getProfile();

		if (user.getProfile().getMentee() != null) {
			Mentee mentee = user.getProfile().getMentee();
			for (Job job : jobs) {
				if (job == null) {
					continue;
				}
				System.out.println("This jobs mentors"+job.getMentors());
				Job j = jRepo.findById(job.getId()).get();
				System.out.println("adding " + j + " to " + mentee);
				mentee.addJob(j);
			}
			System.out.println(mentee);
			menteeRepo.save(mentee);
			menteeRepo.flush();
			p.setMentee(mentee);
			return p;

		} else {
			Mentor mentor = user.getProfile().getMentor();
			for (Job job : jobs) {
				if (job == null) {
					continue;
				}
				Job j = jRepo.findById(job.getId()).get();
				mentor.addJob(j);
			}
			System.out.println(mentor);
			mentorRepo.save(mentor);
			mentorRepo.flush();
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

	@Override
	public Set<Profile> getMenteesWithJobs(String name) {
		User user = uRepo.findUserByUsername(name);
		Collection<Job> jobs =  user.getProfile().getMentor().getJobs();
		System.out.println(jobs);
		Set<Profile> profiles = new HashSet();
		
		for (Job job : jobs) {
			System.out.println(job);
			try {
				System.out.println("finding mentees with sector " + job.getSector());
				Mentee mentee = menteeRepo.findByJobs_SectorId(job.getSector().getId());
				System.out.println(mentee);
				Profile p = pRepo.findByMenteeId(mentee.getId());
				profiles.add(p);
			} catch (Exception e) {
				System.out.println("no jobs");
				continue;
			}
		}
		return profiles;
	}

	@Override
	public Set<Profile> addMenteeToMentorList(Profile profile, String name) {
		Profile menteeProfile = pRepo.findProfileById(profile.getId());
		User mentorUser = uRepo.findUserByUsername(name);
		MentorMentee mm = new MentorMentee();
		mm.setMentee(menteeProfile.getMentee());
		mm.setMentor(mentorUser.getProfile().getMentor());
		mentorUser.getProfile().getMentor().addMentorMentees(mm);
		menteeProfile.getMentee().addMentorMentees(mm);
		
		mmRepo.saveAndFlush(mm);
		pRepo.saveAndFlush(menteeProfile);
		pRepo.saveAndFlush(mentorUser.getProfile());
		
		Set<Profile> profiles = new HashSet<Profile>();
		for (MentorMentee men : mentorUser.getProfile().getMentor().getMentorMentees()) {
			Profile p = pRepo.findByMenteeId(men.getId());
			profiles.add(p);
		}
		return profiles;
	}

	@Override
	public Set<Profile> removeMenteeFromMentorList(Profile profile, String name) {
		Profile menteeProfile = pRepo.findProfileById(profile.getId());
		User mentorUser = uRepo.findUserByUsername(name);
		
		mentorUser.getProfile().getMentor().removeMentorMentees(mmRepo.findByMenteeIdAndMentorId(menteeProfile.getMentee().getId(), mentorUser.getProfile().getMentor().getId()));
		menteeProfile.getMentee().removeMentorMentees(mmRepo.findByMenteeIdAndMentorId(menteeProfile.getMentee().getId(), mentorUser.getProfile().getMentor().getId()));
		pRepo.saveAndFlush(mentorUser.getProfile());
		pRepo.saveAndFlush(menteeProfile);
		
		Set<Profile> profiles = new HashSet<Profile>();
		for (MentorMentee men : mentorUser.getProfile().getMentor().getMentorMentees()) {
			Profile p = pRepo.findByMenteeId(men.getId());
			profiles.add(p);
		}
		return profiles;
	}

}
