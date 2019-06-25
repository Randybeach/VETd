import { User } from './user';

export class Review {
  id: number;
  content: string;
  rating: number;
  profileId: number;
  reviewer: User;

  constructor(
    id?: number,
    content?: string,
    rating?: number,
    profileId?: number,
    reviewer?: User,
  ) {
    this.id = id;
    this.content = content;
    this.rating = rating;
    this.profileId = profileId;
    this.reviewer = reviewer;
  }
}
