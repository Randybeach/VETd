import { Component, OnInit } from "@angular/core";
import { Mentor } from "src/app/models/mentor";
import { Mentee } from "src/app/models/mentee";
import { AuthService } from "src/app/services/auth.service";
import { Router, ActivatedRoute } from "@angular/router";
import { ProfileService } from "src/app/services/profile.service";
import { Review } from "src/app/models/review";

@Component({
  selector: "app-mentee-profile",
  templateUrl: "./mentee-profile.component.html",
  styleUrls: ["./mentee-profile.component.css"]
})
export class MenteeProfileComponent implements OnInit {
  mentor = new Mentor();
  mentee = new Mentee();
  profile = null;
  review = new Review();

  constructor(
    private auth: AuthService,
    private router: Router,
    private profileService: ProfileService,
    private route: ActivatedRoute
  ) {}

  ngOnInit() {
    this.getMentee();
    this.getMentor();
  }

  getMentee() {
    // call auth service
  }
  getMentor() {
    // call auth service
  }
  addMenteeToMentorMenteeList(profile) {
    console.log("added " + profile.firstName + " to list");
    this.profileService.addMenteeToMentorList(profile).subscribe(
      good => {
        this.profile = good;
      },
      bad => {
        console.log(bad);
      }
    );
  }

  submitReview() {

  }
}
