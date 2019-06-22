import { ProfileService } from "src/app/services/profile.service";
import { AuthService } from "./../../services/auth.service";
import { Component, OnInit } from "@angular/core";

@Component({
  selector: "app-navigation",
  templateUrl: "./navigation.component.html",
  styleUrls: ["./navigation.component.css"]
})
export class NavigationComponent implements OnInit {
  constructor(
    private auth: AuthService,
    private profileService: ProfileService
  ) {}
  //
  // F E I L D S
  //
  profile = null;

  ngOnInit() {
  }
  //
  // M E T H O D S
  //
  isLoggedIn() {
    return this.auth.checkLogin();
  }
  isAdmin() {
    console.log("in nave bar admin");

    if (!this.auth.checkLogin()) {
      return false;
    }
    if(this.profile === null){
      this.getProfile();
    }

    console.log(this.profile);

    return this.profile.user.role === "admin";
  }
  getProfile() {
    this.profileService.getProfile().subscribe(
      data => {
        this.profile = data;
      },
      err => {
        console.log(err);
      }
    );
  }
}
