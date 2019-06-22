package com.skilldistillery.vetd.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skilldistillery.vetd.entities.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>{

	User findUserByUsername(String username);

	List<User> findUserByUsernameLike(String name);

}
