package com.skilldistillery.vetd.services;

import java.util.List;

import com.skilldistillery.vetd.entities.User;

public interface UserService {

	public List<User> index();

	public List<User> getAllUsers();
}
