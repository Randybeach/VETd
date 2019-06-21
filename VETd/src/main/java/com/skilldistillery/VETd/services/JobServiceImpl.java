package com.skilldistillery.vetd.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Sector;
import com.skilldistillery.vetd.repositories.JobRepository;
import com.skilldistillery.vetd.repositories.SectorRepository;

@Service
public class JobServiceImpl implements JobService {

	@Autowired
	private JobRepository repo;
	@Autowired
	private SectorRepository sRepo;

	@Override
	public List<Job> getAllJobs() {
		return repo.findAll();
	}

	@Override
	public List<Sector> getAllSectors() {
		return sRepo.findAll();
	}
	
}
