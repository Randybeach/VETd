package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skilldistillery.vetd.entities.Job;

@Repository
public interface JobRepository extends JpaRepository<Job, Integer> {

}
