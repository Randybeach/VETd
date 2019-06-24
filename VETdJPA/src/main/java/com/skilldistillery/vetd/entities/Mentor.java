package com.skilldistillery.vetd.entities;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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
public class Mentor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String story;

	@Column(name = "created_at")
	@CreationTimestamp
	private Date createdAt;

	@OneToMany(mappedBy = "mentor")
	private Set<MentorMentee> mentorMentees;

	@ManyToMany(mappedBy = "mentors", cascade = CascadeType.ALL)
	private Set<Job> jobs;

	@OneToOne
	@JoinColumn(name = "profile_id")
	@JsonIgnore
	private Profile profile;

	public void addJob(Job job) {
		if (this.jobs == null) {
			this.jobs = new HashSet();
		}
		this.jobs.add(job);
		job.getMentors().add(this);

	}

	public void removeJob(Job job) {
		if (this.jobs == null) {
			return;
		}
		this.jobs.remove(job);
		job.getMentors().remove(this);
	}

	public void addMentorMentees(MentorMentee mm) {
		if (this.mentorMentees == null) {
			this.mentorMentees = new HashSet<>();
		}
		this.mentorMentees.add(mm);

	}

	public void removeMentorMentees(MentorMentee mm) {
		if (this.mentorMentees == null) {
			return;
		}
		if (this.mentorMentees.contains(mm)) {
			this.mentorMentees.remove(mm);
		}
	}

	public Set<Job> getJobs() {
		return jobs;
	}

	public void setJobs(Set<Job> jobs) {
		this.jobs = jobs;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
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

	public Mentor(int id, String story, Date createdAt) {
		super();
		this.id = id;
		this.story = story;
		this.createdAt = createdAt;
	}

	public Mentor() {
		super();
	}

	public Mentor(int id, String story, Date createdAt, Set<MentorMentee> mentorMentees, Set<Job> jobs,
			Profile profile) {
		super();
		this.id = id;
		this.story = story;
		this.createdAt = createdAt;
		this.mentorMentees = mentorMentees;
		this.jobs = jobs;
		this.profile = profile;
	}

	public Set<MentorMentee> getMentorMentees() {
		return mentorMentees;
	}

	public void setMentorMentees(Set<MentorMentee> mentorMentees) {
		this.mentorMentees = mentorMentees;
	}

	@Override
	public String toString() {
		return "Mentor [id=" + id + ", story=" + story + ", createdAt=" + createdAt + "]";
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
		Mentor other = (Mentor) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
