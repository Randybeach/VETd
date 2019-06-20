export class MentorMentee {
  id: number;
  createdAt: string;
  menteeId: number;
  mentorId: number;

  constructor(
    id?: number,
    createdAt?: string,
    menteeId?: number,
    mentorId?: number
  ) {
    this.id = id;
    this.createdAt = createdAt;
    this.menteeId = menteeId;
    this.mentorId = mentorId;
  }
}
