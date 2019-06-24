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
      console.log('checking admin');

      return false;
    }

    return true;
  }

}
