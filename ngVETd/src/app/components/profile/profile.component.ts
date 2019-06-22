import { AuthService } from "src/app/services/auth.service";
import { ProfileService } from "./../../services/profile.service";
import { Component, OnInit } from "@angular/core";
import { Sector } from "src/app/models/sector";
import { Router, ActivatedRoute } from "@angular/router";
import { Job } from "src/app/models/job";
import { Mentee } from "src/app/models/mentee";
import { Mentor } from "src/app/models/mentor";

@Component({
  selector: "app-profile",
  templateUrl: "./profile.component.html",
  styleUrls: ["./profile.component.css"]
})
export class ProfileComponent implements OnInit {
  //
  // F E I L D S
  // //
  currentSector = null;
  currJobs = [];
  jobs: Job[] = [];
  jobsForSector: Job[] = [];
  jobName = "nothing";
  sectors: Sector[] = [];
  profile = null;
  profileJobs = [];

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private profileService: ProfileService,
    private auth: AuthService
  ) {}
  //
  // M E T H O D S
  //

  ngOnInit() {
    this.reloadSectors();
    this.reloadJobs();
    // console.log(this.auth.getCredentials());
    this.getProfile();
  }

  // getProfile() {

  //   this.profileService.getProfile(id).subscribe(
  //     good => {
  //       console.log(good);

  //     },
  //     err => {
  //       console.log(err);
  //     }
  //   );
  // }

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
        // console.log(this.jobs);
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

    for (let i = 0; i < this.jobs.length; i++) {
      const job = this.jobs[i];
      if (job.sector.id == this.currentSector) {
        this.jobsForSector.push(job);
      }
    }
  }

  setJob() {
    for (let job of this.jobsForSector) {
      if (job.name === this.jobName) {
        this.currJobs.push(job);
      }
    }
    console.log(this.currJobs);
  }

  addJobs() {
    this.profileService.addJobs(this.currJobs).subscribe(
      good => {
        console.log(good);
        this.getProfile();
      },
      err => {
        console.log(err);
      }
    );
  }
  getProfile() {
    this.profileService.getProfile().subscribe(
      good => {
        this.profileJobs = [];
        console.log(good);
        this.profile = good;
        if(this.profile.mentee){
          this.profileJobs = this.profile.mentee.jobs;
          console.log("mentee jobs" + this.profileJobs);

         }else{
          this.profileJobs = [];
          this.profileJobs = this.profile.mentor.jobs;
          console.log("mentor jobs" + this.profileJobs);
        }
      },
      bad => {
        console.log("OOPS");
      }
    );
  }
  editProfile() {
    this.router.navigateByUrl("edit");
  }
  removeJob(job){
    this.profileService.removeJob(job).subscribe(
      good => {
        this.getProfile();
        // this.profile = good;
        // this.profileJobs.filt
        console.log("removed job " + good);

      }
    );
  }
}
