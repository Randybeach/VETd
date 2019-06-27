package com.skilldistillery.vetd.services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.Message;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.Review;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.repositories.JobRepository;
import com.skilldistillery.vetd.repositories.LocationRepository;
import com.skilldistillery.vetd.repositories.MenteeRepository;
import com.skilldistillery.vetd.repositories.MentorMenteeRepository;
import com.skilldistillery.vetd.repositories.MentorRepository;
import com.skilldistillery.vetd.repositories.MessageRepository;
import com.skilldistillery.vetd.repositories.ProfileRepository;
import com.skilldistillery.vetd.repositories.ReviewRepository;
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
	@Autowired
	private ReviewRepository rRepo;
	@Autowired
	private MessageRepository messageRepo;

	@Override
	public List<User> index() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getAllUsers() {
		List<User> users = uRepo.findAll();
		for (User user : users) {
			user.setProfile(pRepo.findByUser_Username(user.getUsername()));

		}
		return users;
	}

	@Override
	public Mentee getMenteeById(int id) {

		return menteeRepo.findMenteeById(id);
	}

	@Override
	public Set<Profile> getMentorsByMenteeUsername(String name) {
		User u = uRepo.findUserByUsername(name);
		Set<MentorMentee> mentors = new HashSet<MentorMentee>();
		Set<Profile> mentorProfiles = new HashSet<Profile>();
		mentors = mmRepo.findByMenteeId(u.getProfile().getMentee().getId());
		for (MentorMentee mm : mentors) {
			Profile p = pRepo.findByMentorId(mm.getMentor().getId());
			System.out.println(p.getUser());
			mentorProfiles.add(pRepo.findByMentorId(mm.getMentor().getId()));
		}
		System.out.println("&&& " + mentorProfiles);
		return mentorProfiles;
	}

	@Override
	public Set<Profile> getMenteesByMentorUsername(String name) {
		User u = uRepo.findUserByUsername(name);
		Set<MentorMentee> mentees = new HashSet<MentorMentee>();
		Set<Profile> menteeProfiles = new HashSet<Profile>();
		mentees = mmRepo.findByMentorId(u.getProfile().getMentor().getId());
		for (MentorMentee mm : mentees) {
			menteeProfiles.add(pRepo.findByMenteeId(mm.getMentee().getId()));
		}
		return menteeProfiles;
	}

	@Override
	public Profile updateMentee(Profile profile) {
		System.out.println(profile);

		if (profile.getMentee() != null) {
			profile.getMentee().setProfile(profile);
			pRepo.saveAndFlush(profile);
			menteeRepo.saveAndFlush(profile.getMentee());
			if (profile.getMentee().getJobs() != null) {
				Collection<Job> jobs = profile.getMentee().getJobs();
				for (Job job : jobs) {
					profile = this.removeJobsFromMentee(job, profile.getUser().getUsername());
				}
				profile = this.addJobstoMentee(jobs, profile.getUser().getUsername());
			}

		} else {
			profile.getMentor().setProfile(profile);
			pRepo.saveAndFlush(profile);
			mentorRepo.saveAndFlush(profile.getMentor());
			if (profile.getMentor().getJobs() != null) {
				Collection<Job> jobs = profile.getMentor().getJobs();
				for (Job job : jobs) {
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
				System.out.println("This jobs mentors" + job.getMentors());
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
			job.removeMentee(mentee);
			jRepo.saveAndFlush(job);
			System.out.println(mentee);
			menteeRepo.saveAndFlush(mentee);
			p.setMentee(mentee);
			pRepo.saveAndFlush(p);
			System.out.println(p.getMentee().getJobs());
			return p;
		} else {
			Mentor mentor = user.getProfile().getMentor();

			mentor.removeJob(job);
			job.removeMentor(mentor);
			jRepo.saveAndFlush(job);
			System.out.println(mentor);
			mentorRepo.saveAndFlush(mentor);
			p.setMentor(mentor);
			pRepo.saveAndFlush(p);
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
	public List<Profile> getProfilesByUser_Username(String name) {
		name = "%" + name + "%";
		System.out.println(" *&^ " + name);
		return pRepo.findByUser_UsernameLike(name);
	}

	@Override
	public Set<Profile> getMenteesWithJobs(String name) {
		User user = uRepo.findUserByUsername(name);
		Collection<Job> jobs = user.getProfile().getMentor().getJobs();
		Set<Profile> profiles = new HashSet<>();
		for (Job job : jobs) {
			try {
				Mentee mentee = menteeRepo.findByJobs_SectorId(job.getSector().getId());
				Profile p = pRepo.findByMenteeId(mentee.getId());
				profiles.add(p);
			} catch (Exception e) {
				continue;
			}
		}
		Set<Profile> mentorsMenteesList = new HashSet<>();
		mentorsMenteesList = getMenteesByMentorUsername(name);
		Set<Integer> profileIds = new HashSet<>(mentorsMenteesList.size());
		Set<Profile> availableMentees = new HashSet<>();
		for (Profile profile : mentorsMenteesList) {
			profileIds.add(profile.getId());
		}
		for (Profile profile : profiles) {
			if (!profileIds.contains(profile.getId())) {
				availableMentees.add(profile);
			}
		}
		return availableMentees;
	}

	@Override
	public Set<Profile> addMenteeToMentorList(Profile profile, String name) {
		System.out.println("@@ new Mentees profile " + profile);
		Profile menteeProfile = pRepo.findProfileById(profile.getId());
		User mentorUser = uRepo.findUserByUsername(name);
		Collection<MentorMentee> menteeList = new ArrayList<MentorMentee>();
		menteeList.addAll(mentorUser.getProfile().getMentor().getMentorMentees());

		MentorMentee m = new MentorMentee();
		m.setMentee(menteeProfile.getMentee());
		m.setMentor(mentorUser.getProfile().getMentor());

		mentorUser.getProfile().getMentor().addMentorMentees(m);
		menteeProfile.getMentee().addMentorMentees(m);

		mmRepo.saveAndFlush(m);
		System.out.println("%%% " + mentorUser.getProfile());
		pRepo.saveAndFlush(mentorUser.getProfile());
		System.out.println(getMenteesByMentorUsername(mentorUser.getUsername()));
		return getMenteesByMentorUsername(mentorUser.getUsername());

	}

	@Override
	public void removeMenteeFromMentorList(Profile profile, String name) {
		Profile menteeProfile = pRepo.findProfileById(profile.getId());
		User mentorUser = uRepo.findUserByUsername(name);
		System.out.println(" ***************************** mentorUser in remove mentee from mentor list" + mentorUser);
		mentorUser.getProfile().getMentor().removeMentorMentees(mmRepo.findByMenteeIdAndMentorId(
				menteeProfile.getMentee().getId(), mentorUser.getProfile().getMentor().getId()));
		menteeProfile.getMentee().removeMentorMentees(mmRepo.findByMenteeIdAndMentorId(
				menteeProfile.getMentee().getId(), mentorUser.getProfile().getMentor().getId()));
		pRepo.saveAndFlush(mentorUser.getProfile());
		pRepo.saveAndFlush(menteeProfile);
		System.out.println("*********** removed mentee ********* from mentor list");
		mmRepo.delete(mmRepo.findByMenteeIdAndMentorId(menteeProfile.getMentee().getId(),
				mentorUser.getProfile().getMentor().getId()));
		getMenteesByMentorUsername(name);
	}

	@Override
	public Set<Review> getReviewsByProfileId(String name) {

		return rRepo.findReviewByProfileId(uRepo.findUserByUsername(name).getProfile().getId());
	}

	@Override
	public Set<MentorMentee> addMessage(Message message, String name, int id) {
		MentorMentee ment = mmRepo.findById(id).get();
		message.setMentorMentee(ment);
		System.out.println("#@ " + message);
		User user = uRepo.findUserByUsername(name);
		messageRepo.saveAndFlush(message);
		Set<MentorMentee> mm = null;
		if (user.getProfile().getMentee() == null) {
			mm = user.getProfile().getMentor().getMentorMentees();

		} else {
			mm = user.getProfile().getMentee().getMentorMentee();
		}
		return mm;
	}

	@Override
	public Review postNewReview(Review review, String name, int pid) {
		User user = uRepo.findUserByUsername(name);
		Optional<Profile> profileOpt = pRepo.findById(pid);
		if (profileOpt.isPresent()) {
			Profile profile = profileOpt.get();
			review.setProfile(profile);
		}
		review.setReviewer(user);
		return rRepo.saveAndFlush(review);
	}

	@Override
	public List<Message> getMessages() {

		return messageRepo.findAll();
	}

	@Override
	public List<Profile> getAllProfiles() {
		// TODO Auto-generated method stub
		return pRepo.findAll();
	}

}
