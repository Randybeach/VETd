package com.skilldistillery.vetd.services;

import java.util.List;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Sector;

public interface JobService {

	List<Job> getAllJobs();

	List<Sector> getAllSectors();

}
