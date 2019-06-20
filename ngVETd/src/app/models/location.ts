export class Location {
  id: number;
  city: string;
  state: string;
  zip: string;

  constructor(
    id?: number,
    city?: string,
    state?: string,
    zip?: string
  ) {
    this.id = id;
    this.city = city;
    this.state = state;
    this.zip = zip;
  }
}
