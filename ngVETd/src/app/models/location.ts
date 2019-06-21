export class Location {
  id: number;
  city: string;
  state: string;
  zipcode: string;

  constructor(
    id?: number,
    city?: string,
    state?: string,
    zipcode?: string
  ) {
    this.id = id;
    this.city = city;
    this.state = state;
    this.zipcode = zipcode;
  }
}
