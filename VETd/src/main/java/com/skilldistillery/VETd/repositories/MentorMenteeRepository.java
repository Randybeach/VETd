package com.skilldistillery.vetd.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.MentorMentee;

public interface MentorMenteeRepository extends JpaRepository<MentorMentee, Integer> {

	public List<MentorMentee> findByMenteeId(int id);
	public List<MentorMentee> findByMentorId(int id);
}
