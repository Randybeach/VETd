package com.skilldistillery.vetd.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.User;
import com.skilldistillery.vetd.repositories.MenteeRepository;
import com.skilldistillery.vetd.repositories.MentorMenteeRepository;
import com.skilldistillery.vetd.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository uRepo;
	@Autowired
	private MenteeRepository mRepo;
	@Autowired
	private MentorMenteeRepository mmRepo;
	
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
		
		return mRepo.findMenteeById(id);
	}


	@Override
	public List<MentorMentee> getMentorsByMenteeId(int id) {
		return mmRepo.findByMenteeId(id);
	}


	@Override
	public List<MentorMentee> getMenteesByMentorId(int id) {
		return mmRepo.findByMentorId(id);
	}

}
