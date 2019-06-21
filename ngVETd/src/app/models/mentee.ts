import { Profile } from './profile';

export class Mentee {
  id: number;
  story: string;
  createdAt: string;
  profile: Profile;

  constructor(
    id?: number,
    story?: string,
    createdAt?: string,
    profile?: Profile
  ) {
    this.id = id;
    this.story = story;
    this.createdAt = createdAt;
    this.profile = profile;
  }
}
