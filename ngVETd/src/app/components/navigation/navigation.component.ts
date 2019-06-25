import { ProfileService } from "src/app/services/profile.service";
import { AuthService } from "./../../services/auth.service";
import { Component, OnInit } from "@angular/core";
import { Router } from '@angular/router';

@Component({
  selector: "app-navigation",
  templateUrl: "./navigation.component.html",
  styleUrls: ["./navigation.component.css"]
})
export class NavigationComponent implements OnInit {
  constructor(
    private auth: AuthService,
    private profileService: ProfileService,
    private router: Router
  ) {}
  //
  // F E I L D S
  //
  getCurrentRoute(): string {
    console.log(this.router.url);

    return this.router.url;
  }

  ngOnInit() {
  }
  //
  // M E T H O D S
  //
  isLoggedIn() {
    return this.auth.checkLogin();
  }
  isAdmin() {

    if (!this.auth.checkLogin()) {
      return false;
    }
    if (!this.auth.checkAdmin()){
      // console.log('checking admin');

      return false;
    }

    return true;
  }

}
