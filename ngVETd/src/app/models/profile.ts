export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  summary: string;
  createdAt: string;
  locationId: number;
  mentorId: number;
  menteeId: number;
  pic: string;
  resume: string;

  constructor(
    id?: number,
    firstName?: string,
    lastName?: string,
    summary?: string,
    createdAt?: string,
    locationId?: number,
    mentorId?: number,
    menteeId?: number,
    pic?: string,
    resume?: string
  ) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.summary = summary;
    this.createdAt = createdAt;
    this.locationId = locationId;
    this.mentorId = mentorId;
    this.menteeId = menteeId;
    this.pic = pic;
    this.resume = resume;
  }
}
