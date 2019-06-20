package com.skilldistillery.vetd.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.repositories.UserRepository;
import com.skilldistillery.vetd.entities.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository uRepo;
	
	
	@Override
	public List<User> index() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<User> getAllUsers() {
		
		return uRepo.findAll();
	}

}
