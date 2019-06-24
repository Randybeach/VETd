package com.skilldistillery.vetd.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Review;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
	
	Set<Review> findReviewByProfileId(int pid);

}
