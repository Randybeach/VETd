package com.skilldistillery.vetd.services;

import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.Mentor;
import com.skilldistillery.vetd.entities.User;

public interface AuthService {

	public User register(User user);
	public Mentee registerMentee(Mentee mentee);
	public Mentor registerMentor(Mentor mentor);
}
