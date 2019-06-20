package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skilldistillery.vetd.entities.Location;
@Repository
public interface LocationRepository extends JpaRepository<Location, Integer> {

	
}
