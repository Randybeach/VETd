import { Sector } from './sector';
export class Job {
  id: number;
  sector: Sector;
  name: string;

  constructor(
    id?: number,
    sector?: Sector,
    name?: string
    ) {
    this.id = id;
    this.sector = sector;
    this.name = name;
  }
}
