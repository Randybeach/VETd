export class Job {
  id: number;
  sectorId: number;
  name: string;

  constructor(
    id?: number,
    sectorId?: number,
    name?: string
    ) {
    this.id = id;
    this.sectorId = sectorId;
    this.name = name;
  }
}
