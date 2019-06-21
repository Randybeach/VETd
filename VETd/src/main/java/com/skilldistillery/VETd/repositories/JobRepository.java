package com.skilldistillery.vetd.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skilldistillery.vetd.entities.Job;

@Repository
public interface JobRepository extends JpaRepository<Job, Integer> {

//	public List<Job> findJobsbySectorId(int id);
}
