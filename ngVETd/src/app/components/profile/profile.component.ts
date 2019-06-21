import { ProfileService } from "./../../services/profile.service";
import { Component, OnInit } from "@angular/core";
import { Sector } from "src/app/models/sector";
import { Router, ActivatedRoute } from "@angular/router";
import { Job } from "src/app/models/job";

@Component({
  selector: "app-profile",
  templateUrl: "./profile.component.html",
  styleUrls: ["./profile.component.css"]
})
export class ProfileComponent implements OnInit {
  //
  // F E I L D S
  // //

  sectors: Sector[] = [];

  jobs: Job[] = [];

  jobsForSector: Job[] = [];

  currentSector = null;

  selectedJob = new Job();

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private profileService: ProfileService
  ) {}
  //
  // M E T H O D S
  //

  ngOnInit() {
    this.reloadSectors();
    this.reloadJobs();
    console.log(this.reloadSectors());
  }

  reloadSectors() {
    this.profileService.getSectors().subscribe(
      good => {
        this.sectors = good;
      },
      err => {
        console.log(err);
      }
    );
  }

  reloadJobs() {
    this.profileService.getJobs().subscribe(
      good => {
        this.jobs = good;
        console.log(this.jobs);
      },
      err => {
        console.log(err);
      }
    );
  }

  getJobBySector() {
    this.jobsForSector = [];
    console.log("clicked");
    console.log(this.currentSector);
    console.log(this.jobs);

    for (let i = 0; i < this.jobs.length; i++) {
      const job = this.jobs[i];
      if (job.sector.id == this.currentSector) {
        this.jobsForSector.push(job);
      }
    }
  }
  setJob(job) {
    this.selectedJob = job;
    console.log(this.selectedJob);

  }

  addJob() {

  }
}
