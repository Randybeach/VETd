package com.skilldistillery.vetd.entities;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
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
	@ManyToMany(cascade = CascadeType.MERGE)
	@JoinTable(name = "mentor_job", joinColumns=@JoinColumn(name = "job_id"), inverseJoinColumns = @JoinColumn(name = "mentor_id"))
	@JsonIgnore
	private Set<Mentor> mentors;
	@ManyToMany(cascade = CascadeType.MERGE)
	@JoinTable(name = "mentee_job", joinColumns = @JoinColumn(name = "job_id"), inverseJoinColumns = @JoinColumn(name = "mentee_id"))
	@JsonIgnore
	private Set<Mentee> mentees;
	
	
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
		this.mentees = new HashSet<Mentee>();
		this.mentors = new HashSet<Mentor>();
	}
	public Job(int id, String name, Sector sector) {
		super();
		this.id = id;
		this.name = name;
		this.sector = sector;
		this.mentees = new HashSet<Mentee>();
		this.mentors = new HashSet<Mentor>();
	}
	@Override
	public String toString() {
		return "Job [id=" + id + ", name=" + name + ", sector=" + sector + "]";
	}
	public Set<Mentor> getMentors() {
		return mentors;
	}
	public void setMentors(Set<Mentor> mentors) {
		this.mentors = mentors;
	}
	public Set<Mentee> getMentees() {
		return mentees;
	}
	public void setMentees(Set<Mentee> mentees) {
		this.mentees = mentees;
	}
	
	public void addMentor(Mentor m) {
		if (mentors == null) {
			mentors = new HashSet<Mentor>();
		}
		if (!mentors.contains(m)) {
			mentors.add(m);
			m.addJob(this);
		}
		
	}
	public void addMentee(Mentee m) {
		if (mentees == null) {
			mentees = new HashSet<Mentee>();
		}
		if (!mentees.contains(m)) {
			mentees.add(m);
			m.addJob(this);
		}
		
	}
	
	public void removeMentor(Mentor m) {
		if (mentors != null && mentors.contains(m)) {
			mentors.remove(m);
			m.removeJob(this);
		}
		
	}
	public void removeMentee(Mentee m) {
		if (mentees != null && mentees.contains(m)) {
			mentees.remove(m);
			m.removeJob(this);
		}
		
	}
	
	
	

}
