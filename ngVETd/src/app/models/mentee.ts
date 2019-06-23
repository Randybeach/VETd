import { Profile } from './profile';
import { Job } from './job';

export class Mentee {
  id: number;
  story: string;
  createdAt: string;
  profile: Profile;
  jobs: Job[];

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
