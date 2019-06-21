package com.skilldistillery.vetd.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.vetd.entities.Sector;

public interface SectorRepository extends JpaRepository<Sector, Integer> {

}
