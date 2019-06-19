import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';

@Component({
  selector: "app-logout",
  templateUrl: "./logout.component.html",
  styleUrls: ["./logout.component.css"]
})
export class LogoutComponent implements OnInit {
  //
  // F E I L D S
  //

  constructor(private auth: AuthService, private router: Router) {}

  //
  // M E T H O D S
  //

  ngOnInit() {}

  logout() {
    console.log("logout");
    this.auth.logout();
    this.router.navigateByUrl("home");
  }
}
