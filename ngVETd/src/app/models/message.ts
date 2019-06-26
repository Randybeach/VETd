import { MentorMentee } from './mentor-mentee';
import { Profile } from './profile';

export class Message {

  id: number;
  mentorMentee: MentorMentee;
  text: string;
  profileId: number;
  createdAt: string;


constructor(
    id?: number,
    mentorMentee?: MentorMentee,
    text?: string,
    profileId?: number,
    createdAt?: string
) {
  this.id = id;
  this.mentorMentee = mentorMentee;
  this.text = text;
  this.profileId = profileId;
  this.createdAt = createdAt;
  }
}
