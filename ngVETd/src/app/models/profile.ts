import { Mentee } from 'src/app/models/mentee';
import { Mentor } from 'src/app/models/mentor';
import { Location } from './location';
import { User } from './user';
import { MentorMentee } from './mentor-mentee';
import { Review } from './review';

export class Profile {
  id: number;
  firstName: string;
  lastName: string;
  summary: string;
  createdAt: string;
  location: Location;
  mentor: Mentor;
  mentee: Mentee;
  pictureUrl: string;
  resumeUrl: string;
  user: User;
  mentormentee: MentorMentee [];
  reviews: Review [];

  constructor(
    id?: number,
    firstName?: string,
    lastName?: string,
    summary?: string,
    createdAt?: string,
    location?: Location,
    mentor?: Mentor,
    mentee?: Mentee,
    pictureUrl?: string,
    resumeUrl?: string,
    user?: User,
  ) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.summary = summary;
    this.createdAt = createdAt;
    this.location = location;
    this.mentor = mentor;
    this.mentee = mentee;
    this.pictureUrl = pictureUrl;
    this.resumeUrl = resumeUrl;
    this.user = user;
  }
}
