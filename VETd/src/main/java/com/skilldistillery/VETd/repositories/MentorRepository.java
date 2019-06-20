package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Mentor;

public interface MentorRepository extends JpaRepository<Mentor, Integer> {

}
