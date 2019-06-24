package com.skilldistillery.vetd.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class MentorMentee {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@CreationTimestamp
	@JoinColumn(name = "created_at")
	private Date createdAt;
	
	@ManyToOne
	@JoinColumn(name = "mentee_id")
	private Mentee mentee;
	
	@ManyToOne
	@JoinColumn(name = "mentor_id")
	@JsonIgnore
	private Mentor mentor;

	public Date getDate() {
		return createdAt;
	}

	public void setDate(Date date) {
		this.createdAt = date;
	}

	public Mentee getMentees() {
		return mentee;
	}

	public void setMentees(Mentee mentees) {
		this.mentee = mentees;
	}

	public MentorMentee() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Mentee getMentee() {
		return mentee;
	}

	public void setMentee(Mentee mentee) {
		this.mentee = mentee;
	}

	public Mentor getMentor() {
		return mentor;
	}

	public void setMentor(Mentor mentor) {
		this.mentor = mentor;
	}

	public MentorMentee(int id, Date createdAt, Mentee mentee, Mentor mentor) {
		super();
		this.id = id;
		this.createdAt = createdAt;
		this.mentee = mentee;
		this.mentor = mentor;
	}

	@Override
	public String toString() {
		return "MentorMentee [id=" + id + ", createdAt=" + createdAt + ", mentee=" + mentee + ", mentor=" + mentor
				+ "]";
	}

}
