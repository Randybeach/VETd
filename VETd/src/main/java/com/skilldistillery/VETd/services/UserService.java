package com.skilldistillery.vetd.services;

import java.util.List;

import com.skilldistillery.vetd.entities.Mentee;
import com.skilldistillery.vetd.entities.MentorMentee;
import com.skilldistillery.vetd.entities.User;

public interface UserService {

	public List<User> index();

	public List<User> getAllUsers();

	public Mentee getMenteeById(int id);

	public List<MentorMentee> getMentorsByMenteeId(int id);

	public List<MentorMentee> getMenteesByMentorId(int id);
}
