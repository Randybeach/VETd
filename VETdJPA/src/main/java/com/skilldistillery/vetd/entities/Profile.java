package com.skilldistillery.vetd.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Profile {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "location_id")
	private Location location;
	private String summary;
	@CreationTimestamp
	@Column(name = "created_at")
	private Date createdAt;
	@OneToMany(mappedBy = "profile")
	private List<Review> reviews;
	@OneToOne(mappedBy = "profile")
	private Mentor mentor;
	@OneToOne(mappedBy = "profile")
	private Mentee mentee;
	@Column(name = "picture_url")
	private String pictureUrl;
	@Column(name = "resume_url")
	private String resumeUrl;
	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	
	
	
	
	public String getPictureUrl() {
		return pictureUrl;
	}
	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	public String getResumeUrl() {
		return resumeUrl;
	}
	public void setResumeUrl(String resumeUrl) {
		this.resumeUrl = resumeUrl;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<Review> getReviews() {
		return reviews;
	}
	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}
	public Mentor getMentor() {
		return mentor;
	}
	public void setMentor(Mentor mentor) {
		this.mentor = mentor;
	}
	public Mentee getMentee() {
		return mentee;
	}
	public void setMentee(Mentee mentee) {
		this.mentee = mentee;
	}
	public String getPic() {
		return pictureUrl;
	}
	public void setPic(String pic) {
		this.pictureUrl = pic;
	}
	public String getResume() {
		return resumeUrl;
	}
	public void setResume(String resume) {
		this.resumeUrl = resume;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Location getLocation() {
		return location;
	}
	public void setLocation(Location location) {
		this.location = location;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	public Profile(int id, String firstName, String lastName, Location location, String summary, Date createdAt,
			List<Review> reviews, Mentor mentor, Mentee mentee, String pictureUrl, String resumeUrl, User user) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.location = location;
		this.summary = summary;
		this.createdAt = createdAt;
		this.reviews = reviews;
		this.mentor = mentor;
		this.mentee = mentee;
		this.pictureUrl = pictureUrl;
		this.resumeUrl = resumeUrl;
		this.user = user;
	}
	public Profile() {
		super();
	}

	@Override
	public String toString() {
		return "Profile [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", location=" + location
				+ ", summary=" + summary + ", pictureUrl=" + pictureUrl + ", resumeUrl=" + resumeUrl + "]";
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
		Profile other = (Profile) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	

}
