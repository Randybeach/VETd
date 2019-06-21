export class Mentor {
  id: number;
  story: string;
  createdAt: string;
  profileId: number;

  constructor(
    id?: number,
    story?: string,
    createdAt?: string,
    profileId?: number
    ) {
    this.id = id;
    this.story = story;
    this.createdAt = createdAt;
    this.profileId = profileId;
  }
}
