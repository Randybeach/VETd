export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  summary: string;
  createdAt: string;
  locationId: number;
  mentorId: number;
  menteeId: number;
  pictureUrl: string;
  resumeUrl: string;

  constructor(
    id?: number,
    firstName?: string,
    lastName?: string,
    summary?: string,
    createdAt?: string,
    locationId?: number,
    mentorId?: number,
    menteeId?: number,
    pictureUrl?: string,
    resumeUrl?: string
  ) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.summary = summary;
    this.createdAt = createdAt;
    this.locationId = locationId;
    this.mentorId = mentorId;
    this.menteeId = menteeId;
    this.pictureUrl = pictureUrl;
    this.resumeUrl = resumeUrl;
  }
}
