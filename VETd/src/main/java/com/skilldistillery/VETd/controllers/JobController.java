package com.skilldistillery.vetd.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.vetd.entities.Job;
import com.skilldistillery.vetd.entities.Sector;
import com.skilldistillery.vetd.services.JobService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost:4202" })
public class JobController {

	@Autowired
	private JobService svc;
	
	@GetMapping("jobs")
	public List<Job> getAllJobs(){
		return svc.getAllJobs();
	}
	@GetMapping("sectors")
	public List<Sector> getAllSectors(){
		return svc.getAllSectors();
	}
	
}
