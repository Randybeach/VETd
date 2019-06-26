import { User } from 'src/app/models/user';
import { AuthService } from "src/app/services/auth.service";
import { ProfileService } from "./../../services/profile.service";
import { Component, OnInit, Inject } from "@angular/core";
import { Sector } from "src/app/models/sector";
import { Router, ActivatedRoute } from "@angular/router";
import { Job } from "src/app/models/job";
import { Mentee } from "src/app/models/mentee";
import { Mentor } from "src/app/models/mentor";
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { ModalComponent } from 'src/app/modal/modal.component';
import { DialogData } from 'src/app/DialogData';
import { Profile } from 'src/app/models/profile';
import { Message } from 'src/app/models/message';

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
  jobName = 'nothing';
  sectors: Sector[] = [];
  profile = null;
  profileJobs = [];
  menteeJobList = [];
  animal: string;
  name: string;
  selectedProfile: Profile = null;
  mentorMenteesList = [];
  menteeMentorsList = [];
  messages: Message [] = [];

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private profileService: ProfileService,
    private auth: AuthService,
    public dialog: MatDialog
  ) {}
  //
  // M E T H O D S
  //

    ngOnInit() {
      this.reloadSectors();
      this.reloadJobs();
      // console.log(this.auth.getCredentials());
      this.getProfile();
      this.getListOfMenteesWithSelectedJobs();
    }

  openDialog(profile: Profile, messages: Message[]): void {
    console.log(' dia 1 ' + profile);

    const dialogRef = this.dialog.open(ModalComponent, {
      width: '80%',
      height: '90%',
      data: {profile, messages}
    });

    dialogRef.afterClosed().subscribe(result => {
      this.getListOfMenteesByMentorId(this.profile);
      this.getListOfMenteesWithSelectedJobs();
    });
  }

  openDialog2(profile: Profile, myProfile: Profile, messages: Message[]): void {
    console.log('dia 2 ' + profile.firstName + ' ' + myProfile.firstName);

    const dialogRef = this.dialog.open(ModalComponent, {
      width: '80%',
      height: '90%',
      data: {profile, myProfile, messages}
    });

    dialogRef.afterClosed().subscribe(result => {
      this.getListOfMenteesByMentorId(this.profile);
    });
  }

  viewMenteeProfile(profile: Profile) {
    this.router.navigateByUrl('mentee_profile');
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
        this.getListOfMenteesWithSelectedJobs();
      },
      err => {
        console.log(err);
      }
    );
  }
  getProfile(): Profile {
    this.profileService.getProfile().subscribe(
      good => {
        if(good === null) {
          localStorage.setItem('admin', 'admin');
          console.log('setting admin');
          this.router.navigateByUrl('admin');

        }
        this.profileJobs = [];
        console.log(good);
        this.profile = good;
        console.log(this.profile.user.role);

        if (this.profile.mentee) {
          localStorage.setItem('mentee', this.profile.user.role);
          this.profileJobs = this.profile.mentee.jobs;
          this.getListOfMentorsByMenteeId(this.profile);
          console.log('mentee jobs' + this.profileJobs);


        } else {
          localStorage.setItem('mentor', this.profile.user.role);
          this.profileJobs = [];
          this.profileJobs = this.profile.mentor.jobs;
          this.getListOfMenteesByMentorId(this.profile);
          // this.removeCurrentMenteesFromPotential();
          console.log('mentor jobs' + this.profileJobs);
        }
        return this.profile;

      },
      bad => {
        console.log('OOPS');
      }
    );
    return null;
  }

  editProfile() {
    this.router.navigateByUrl('edit');
  }
  removeJob(job) {
    this.profileService.removeJob(job).subscribe(
      good => {
        this.getProfile();
        console.log('removed job ' + good);

      }
    );
  }
  getListOfMenteesWithSelectedJobs() {
    this.profileService.getListOfMenteesWithChosenJobs().subscribe(
      good => {
        this.menteeJobList = good;
      },
      err => {
        console.log('problem loading menteeJobList ' + err);

      }
    );

  }

  getListOfMentorsByMenteeId(profile) {
    console.log(profile.id);

    this.profileService.getMentorsByMenteeId(profile.id).subscribe(
      good => {
        this.menteeMentorsList = good;
        console.log(good);
        console.log('in prof comp, get mentor list');
      },
      bad => {
        console.log('error getting mentor list');
        console.log(bad);
      }
    );
  }

  getListOfMenteesByMentorId(profile: Profile) {
    console.log(profile.id + " mentors id");
    this.profileService.getMenteesByMentorId(profile.id).subscribe(

      good => {
        this.mentorMenteesList = good;
        console.log(good);
        console.log('in prof comp, get mentee list');
      },
      bad => {
        console.log('error getting mentee list');
        console.log(bad);
      }
    );
  }

  addMenteeToMentorMenteeList(profile) {
    console.log("added " +  profile.firstName + " to list");
    this.profileService.addMenteeToMentorList(profile).subscribe(
      good => {
        this.mentorMenteesList = good;
        this.getListOfMenteesWithSelectedJobs();
        console.log(good);

      },
      bad => {
        console.log('error adding mentee');

        console.log(bad);

      }
    );
  }

  counter(i: number) {
    return new Array(i);
}
}
