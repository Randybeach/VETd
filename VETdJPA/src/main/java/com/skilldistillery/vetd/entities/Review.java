package com.skilldistillery.vetd.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Review {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String content;
	private int rating;
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "profile_id")
	private Profile profile;
	@Column(name = "reviewed_id")
	private int reviewedId;
	
	
	
	
	public Review(int id, String content, int rating, Profile profile, int reviewedId) {
		super();
		this.id = id;
		this.content = content;
		this.rating = rating;
		this.profile = profile;
		this.reviewedId = reviewedId;
	}
	public int getReviewedId() {
		return reviewedId;
	}
	public void setReviewedId(int reviewedId) {
		this.reviewedId = reviewedId;
	}
	public Review(int id, String content, int rating) {
		super();
		this.id = id;
		this.content = content;
		this.rating = rating;
	}
	public Review() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	public Profile getProfile() {
		return profile;
	}
	public void setProfile(Profile profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "Review [id=" + id + ", content=" + content + ", rating=" + rating + "]";
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
		Review other = (Review) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
}
