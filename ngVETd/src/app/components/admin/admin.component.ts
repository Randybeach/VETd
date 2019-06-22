import { Component, OnInit } from "@angular/core";
import { NgForm } from "@angular/forms";
import { User } from 'src/app/models/user';
import { ProfileService } from 'src/app/services/profile.service';

@Component({
  selector: "app-admin",
  templateUrl: "./admin.component.html",
  styleUrls: ["./admin.component.css"]
})
export class AdminComponent implements OnInit {
  //
  // F E I L D S
  //
  users: User[] = [];

  constructor(private profileService: ProfileService) {}

  //
  // M E T H O D S
  //

  ngOnInit() {
    this.reloadUsers();
  }

  searchUsers(form: NgForm) {}
  searchChatrooms(form: NgForm) {}

  reloadUsers() {
    this.profileService.getUsers().subscribe(
      good => {
        this.users = good;
      },
      err => {
        console.log(err);
      }
    );
  }
}
