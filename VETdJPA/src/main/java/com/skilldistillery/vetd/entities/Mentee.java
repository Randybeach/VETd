package com.skilldistillery.vetd.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

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
	private List<MentorMentee> mentorMentee;
	@ManyToMany(mappedBy = "mentees")
	private List<Job> jobs;
	
	
	
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
		return "Mentee [id=" + id + ", story=" + story + ", createdAt=" + createdAt + "]";
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
