package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Profile;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

	Profile findProfileById(int id);

	Profile findByUser_Username(String name);

}
