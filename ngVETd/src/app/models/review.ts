export class Review {
  id: number;
  content: string;
  rating: number;
  profileId: number;
  reviewedId: number;

  constructor(
    id?: number,
    content?: string,
    rating?: number,
    profileId?: number,
    reviewedId?: number,
  ) {
    this.id = id;
    this.content = content;
    this.rating = rating;
    this.profileId = profileId;
    this.reviewedId = reviewedId;
  }
}
