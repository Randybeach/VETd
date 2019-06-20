export class Mentee {
  id: number;
  story: string;
  createdAt: string;

  constructor(
    id?: number,
    story?: string,
    createdAt?: string
    ) {
    this.id = id;
    this.story = story;
    this.createdAt = createdAt;
  }
}
