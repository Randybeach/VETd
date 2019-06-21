package com.skilldistillery.vetd.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Mentee {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String story;
	@Column(name = "created_at")
	@CreationTimestamp
	private Date createdAt;
	@OneToMany(mappedBy = "mentee")
	@JsonIgnore
	private List<MentorMentee> mentorMentee;
	@ManyToMany(mappedBy = "mentees", cascade = CascadeType.ALL)
	private List<Job> jobs;
	@OneToOne
	@JoinColumn(name = "profile_id")
	private Profile profile;
	
	
	
	

	public Profile getProfile() {
		return profile;
	}
	public void setProfile(Profile profile) {
		this.profile = profile;
	}
	public List<MentorMentee> getMentorMentee() {
		return mentorMentee;
	}
	public void setMentorMentee(List<MentorMentee> mentorMentee) {
		this.mentorMentee = mentorMentee;
	}
	public List<Job> getJobs() {
		return jobs;
	}
	public void setJobs(List<Job> jobs) {
		this.jobs = jobs;
	}
	public void addJob(Job job) {
		if(this.jobs == null) {
			this.jobs = new ArrayList<Job>();
		}
		this.jobs.add(job);
		job.getMentees().add(this);
	}
	public void removeJob(Job job) {
		if(this.jobs == null) {
			return;
		}
		this.jobs.remove(job);
		job.getMentees().remove(this);
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Mentee(int id, String story, Date createdAt) {
		super();
		this.id = id;
		this.story = story;
		this.createdAt = createdAt;
	}
	public Mentee() {
		super();
	}
	@Override
	public String toString() {
		return "Mentee [id=" + id + ", story=" + story + ", createdAt=" + createdAt + ", jobs=" + jobs + ", profile="
				+ profile + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Mentee other = (Mentee) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
}
