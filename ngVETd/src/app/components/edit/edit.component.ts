import { Component, OnInit } from "@angular/core";
import { User } from "src/app/models/user";
import { Mentor } from "src/app/models/mentor";
import { Mentee } from "src/app/models/mentee";
import { AuthService } from "src/app/services/auth.service";
import { Router, ActivatedRoute } from "@angular/router";
import { Profile } from 'src/app/models/profile';
import { Location } from "./../../models/location";

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
  editUser = new User();
  editProfile = new Profile();
  editLocation = new Location();
  editMentor = new Mentor();
  editMentee = new Mentee();

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {}
  //
  // M E T H O D S
  //
  ngOnInit() {}
}
