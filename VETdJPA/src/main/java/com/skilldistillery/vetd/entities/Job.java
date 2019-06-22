package com.skilldistillery.vetd.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Job {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@ManyToOne
	@JoinColumn(name = "sector_id")
	private Sector sector;
	@ManyToMany
	@JoinTable(name = "mentor_job", joinColumns=@JoinColumn(name = "job_id"), inverseJoinColumns = @JoinColumn(name = "mentor_id"))
	@JsonIgnore
	private List<Mentor> mentors;
	@ManyToMany
	@JoinTable(name = "mentee_job", joinColumns = @JoinColumn(name = "job_id"), inverseJoinColumns = @JoinColumn(name = "mentee_id"))
	@JsonIgnore
	private List<Mentee> mentees;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Sector getSector() {
		return sector;
	}
	public void setSector(Sector sector) {
		this.sector = sector;
	}
	public Job() {
		
		super();
		this.mentees = new ArrayList<Mentee>();
		this.mentors = new ArrayList<Mentor>();
	}
	public Job(int id, String name, Sector sector) {
		super();
		this.id = id;
		this.name = name;
		this.sector = sector;
		this.mentees = new ArrayList<Mentee>();
		this.mentors = new ArrayList<Mentor>();
	}
	@Override
	public String toString() {
		return "Job [id=" + id + ", name=" + name + ", sector=" + sector + "]";
	}
	public List<Mentor> getMentors() {
		return mentors;
	}
	public void setMentors(List<Mentor> mentors) {
		this.mentors = mentors;
	}
	public List<Mentee> getMentees() {
		return mentees;
	}
	public void setMentees(List<Mentee> mentees) {
		this.mentees = mentees;
	}
	
	
	
	

}
