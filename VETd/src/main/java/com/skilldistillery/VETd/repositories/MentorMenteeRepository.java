package com.skilldistillery.vetd.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.MentorMentee;

public interface MentorMenteeRepository extends JpaRepository<MentorMentee, Integer> {

//	public List<MentorMentee> findByMenteeId(int id);
	public Set<MentorMentee> findByMentorId(int id);
	public Set<MentorMentee> findByMenteeId(int id);
	public MentorMentee findByMenteeIdAndMentorId(int id, int mid);
	
}
