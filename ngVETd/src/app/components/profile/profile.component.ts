import { ProfileService } from './../../services/profile.service';
import { Component, OnInit } from '@angular/core';
import { Sector } from 'src/app/models/sector';
import { Router, ActivatedRoute } from '@angular/router';
import { Job } from 'src/app/models/job';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  //
  // F E I L D S
  // //

  sectors: Sector[] = [];

  jobs: Job[] = [];

  jobsForSector: Job[] = [];

  constructor(private router: Router, private route: ActivatedRoute, private profileService: ProfileService) {}
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
      },
      err => {
        console.log(err);
      }
    );
  }

  getJobBySector(sector) {
// tslint:disable-next-line: prefer-for-of
    for (let i = 0; i < this.jobs.length; i++) {
      const job = this.jobs[i];
      if (job.sector.id === sector.id) {
        this.jobsForSector.push(job);
      }
    }
  }
}
