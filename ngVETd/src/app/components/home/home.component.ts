import { Component, OnInit } from "@angular/core";
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"]
})
export class HomeComponent implements OnInit {
  //
  // F E I L D S
  //

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  //
  // M E T H O D S
  //
  ngOnInit() {}

  addMentor() {
    this.router.navigateByUrl("/register/mentor");
  }
  addMentee() {
    this.router.navigateByUrl("/register/mentee");
  }
}
