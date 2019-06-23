package com.skilldistillery.vetd.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skilldistillery.vetd.entities.Mentee;

@Repository
public interface MenteeRepository extends JpaRepository<Mentee, Integer> {

	public Mentee findMenteeById(int id);
	public Mentee findByJobs_SectorId(int id);
}
