package com.skilldistillery.vetd.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Location;
import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.Review;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.repositories.LocationRepository;
import com.skilldistillery.vetd.repositories.MenteeRepository;
import com.skilldistillery.vetd.repositories.MentorRepository;
import com.skilldistillery.vetd.repositories.ProfileRepository;
import com.skilldistillery.vetd.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository repo;
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private MentorRepository mentorRepo;
	@Autowired
	private MenteeRepository menteeRepo;
	@Autowired
	private ProfileRepository pRepo;
	@Autowired
	private LocationRepository lRepo;

	@Override
	public User register(User user) {
		user.setPassword(encoder.encode(user.getPassword()));

		user.setEnabled(true);

		user.setRole("standard");

		repo.saveAndFlush(user);
		return user;

	}

	@Override
	public Mentee registerMentee(Mentee mentee) {
		
		Profile profile = mentee.getProfile();
		Location location = profile.getLocation();
		
		User user = profile.getUser();
		repo.saveAndFlush(user);
		profile.setUser(user);
		
		lRepo.saveAndFlush(location);
		profile.setLocation(location);
		
		pRepo.saveAndFlush(profile);
		mentee.setProfile(profile);
		
		mentee.getProfile().getUser().setPassword(encoder.encode(mentee.getProfile().getUser().getPassword()));

		mentee.getProfile().getUser().setEnabled(true);

		mentee.getProfile().getUser().setRole("standard");

		menteeRepo.saveAndFlush(mentee);
		System.out.println(" *** " + mentee);
		return mentee;
	}

	@Override
	public Mentor registerMentor(Mentor mentor) {
		System.out.println(mentor.getProfile());
		Profile profile = mentor.getProfile();
		Location location = profile.getLocation();
		User user = profile.getUser();
		
		
		repo.saveAndFlush(user);
		profile.setUser(user);
		
		lRepo.saveAndFlush(location);
		profile.setLocation(location);
		
		pRepo.saveAndFlush(profile);
		mentor.setProfile(profile);
		
		mentor.getProfile().getUser().setPassword(encoder.encode(mentor.getProfile().getUser().getPassword()));

		mentor.getProfile().getUser().setEnabled(true);

		mentor.getProfile().getUser().setRole("standard");

		mentorRepo.saveAndFlush(mentor);
		// TODO Auto-generated method stub
		return mentor;
	}
}
