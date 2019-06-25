import { ProfileComponent } from './../components/profile/profile.component';
import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { DialogData } from '../DialogData';
import { Profile } from '../models/profile';
import { ProfileService } from '../services/profile.service';
import { AuthService } from '../services/auth.service';
import { Review } from '../models/review';


@Component({
  selector: "app-modal",
  templateUrl: "./modal.component.html",
  styleUrls: ["./modal.component.css"]
})
export class ModalComponent implements OnInit {
  profile = null;
  mentees = [];
  jobs = [];
  myProfile = null;
  review = new Review();

  constructor(
    public dialogRef: MatDialogRef<ModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private profileService: ProfileService
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

  ngOnInit() {
    this.profile = this.data.profile;
    this.myProfile = this.data.myProfile;
    console.log(this.profile);
    this.addMenteesOrMentors();
    console.log(this.myProfile);


    console.log("in init");
  }

  removeMentee(p) {
    this.profile = p;
    console.log("trying to remove " + this.profile.firstName);
    this.profileService
      .removeMenteeFromMentorList(this.profile)
      .subscribe(good => {
        console.log(good);
        console.log("closing window");
        // this.profile = this.profileComp.getProfile();
        // this.profileComp.getListOfMenteesByMentorId(this.profile);
        this.onNoClick();
      });
  }
  addMenteeToMentorMenteeList(p) {
    this.profile = p;
    console.log("added " + this.profile.firstName + " to list");
    this.profileService.addMenteeToMentorList(this.profile).subscribe(
      good => {
        console.log(good);
      },
      bad => {
        console.log("error adding mentee");

        console.log(bad);
      }
    );
  }
  addMenteesOrMentors() {
    if (this.profile.mentor != null) {
      this.mentees = this.profile.mentor.mentorMentees;
      this.jobs = this.profile.mentor.jobs;
      console.log(this.jobs);

      console.log(this.mentees);
    } else {
      this.jobs = this.profile.mentee.jobs;
      this.mentees = this.myProfile.mentor.mentorMentees;
    }
  }
}
