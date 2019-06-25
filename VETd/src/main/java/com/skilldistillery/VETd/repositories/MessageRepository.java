package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Message;


public interface MessageRepository extends JpaRepository<Message, Integer> {

	
	
}
