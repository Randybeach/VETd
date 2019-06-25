import { MentorMentee } from './mentor-mentee';
import { Profile } from './profile';

export class Message {

  id: number;
  mentormentee: MentorMentee;
  text: string;
  profileId: number;
  createdAt: string;


constructor(
    id?: number,
    mentormentee?: MentorMentee,
    text?: string,
    profileId?: number,
    createdAt?: string
) {
  this.id = id;
  this.mentormentee = mentormentee;
  this.text = text;
  this.profileId = profileId;
  this.createdAt = createdAt;
  }
}
