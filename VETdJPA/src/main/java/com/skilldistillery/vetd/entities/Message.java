package com.skilldistillery.vetd.entities;

import java.util.Date;
import java.util.HashSet;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "mentor_mentee_id")
	@JsonIgnore
	private MentorMentee mentorMentee;
	private String text;
	@Column(name = "profile_id")
	private int profileId;
	@Column(name = "created_at")
	@CreationTimestamp
	private Date createdAt;
	
	
	
	
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public void setMentorMentee(MentorMentee mentorMentee) {
		this.mentorMentee = mentorMentee;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public MentorMentee getMentorMentee() {
		return mentorMentee;
	}
	public void setMentorMenteeId(MentorMentee mentorMentee) {
		this.mentorMentee = mentorMentee;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getProfileId() {
		return profileId;
	}
	public void setProfileId(int profileId) {
		this.profileId = profileId;
	}
	public Message(int id, MentorMentee mentorMentee, String text, int profileId) {
		super();
		this.id = id;
		this.mentorMentee = mentorMentee;
		this.text = text;
		this.profileId = profileId;
	}
	public Message() {
		super();
	}
	@Override
	public String toString() {
		return "Message [id=" + id + ", mentorMentee=" + mentorMentee + ", text=" + text + ", profileId=" + profileId
				+ "]";
	}

	
	
}
