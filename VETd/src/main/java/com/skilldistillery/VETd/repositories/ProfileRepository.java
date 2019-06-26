package com.skilldistillery.vetd.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Profile;
import com.skilldistillery.vetd.entities.Review;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

	Profile findProfileById(int id);

	Profile findByUser_Username(String name);

	Profile findByMentee_Jobs_SectorId(int id);

	Profile findByMenteeId(int id);

	Profile findByMentorId(int id);

	List<Profile> findByUser_UsernameLike(String name);

}
