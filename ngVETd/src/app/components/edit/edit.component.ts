import { ProfileService } from "./../../services/profile.service";
import { Component, OnInit } from "@angular/core";
import { User } from "src/app/models/user";
import { Mentor } from "src/app/models/mentor";
import { Mentee } from "src/app/models/mentee";
import { AuthService } from "src/app/services/auth.service";
import { Router, ActivatedRoute } from "@angular/router";
import { Profile } from "src/app/models/profile";
import { Location } from "./../../models/location";
import { NgForm } from "@angular/forms";

@Component({
  selector: "app-edit",
  templateUrl: "./edit.component.html",
  styleUrls: ["./edit.component.css"]
})
export class EditComponent implements OnInit {
  //
  // F E I L D S
  //
  user: User = null;
  editUser: User;
  editProfile: Profile;
  editLocation: Location;
  editVet: Mentee;

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute,
    private profileService: ProfileService
  ) {}
  //
  // M E T H O D S
  //
  ngOnInit() {}

  updateProfile(form1: NgForm, form2: NgForm, form3: NgForm, form4: NgForm) {
    console.log();
    this.editUser = form1.value;
    this.editVet = form2.value;
    this.editProfile = form3.value;
    this.editLocation = form4.value;

    this.editProfile.location = this.editLocation;
    this.editProfile.user = this.editUser;
    this.editVet.profile = this.editProfile;

    this.profileService.update(this.editVet).subscribe(
      data => {
        console.log(this.editVet);
      },
      err => {
        console.log(err);
      }
    );
  }
}
