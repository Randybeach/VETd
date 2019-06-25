import { MentorMentee } from './mentor-mentee';
import { Profile } from './profile';

export class Message {

  id: number;
  mentormentee: MentorMentee;
  text: string;
  profile: Profile;
  createdAt: string;


constructor(
    id?: number,
    mentormentee?: MentorMentee,
    text?: string,
    profile?: Profile,
    createdAt?: string
) {
  this.id = id;
  this.mentormentee = mentormentee;
  this.text = text;
  this.profile = profile;
  this.createdAt = createdAt;
  }
}
