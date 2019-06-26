import { MatDialog } from '@angular/material';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { ProfileService } from 'src/app/services/profile.service';
import { Router } from '@angular/router';
import { ModalComponent } from 'src/app/modal/modal.component';
import { Profile } from 'src/app/models/profile';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {
  //
  // F E I L D S
  //
  users: Profile[] = [];

  keyword = '';

  constructor(private profileService: ProfileService, private router: Router, private dialog: MatDialog) {}

  //
  // M E T H O D S
  //

  ngOnInit() {
    // this.reloadUsers();
  }

  searchUsers() {
    this.profileService.searchUsers(this.keyword).subscribe(
      good => {
        this.users = good;
        console.log(this.users);

      },
      err => {
        console.log(err);
      }
    );
  }

  // searchChatrooms(form: NgForm) {}

  // reloadUsers() {
  //   this.profileService.getUsers().subscribe(
  //     good => {
  //       this.users = good;
  //     },
  //     err => {
  //       console.log(err);
  //     }
  //   );
  // }

  gotoProfile(profile) {
    console.log(profile);
    this.openDialog(profile);
  }
  openDialog(profile: Profile,): void {
    console.log(' dia 1 ' + profile);

    const dialogRef = this.dialog.open(ModalComponent, {
      width: '80%',
      height: '90%',
      data: {profile}
    });

    dialogRef.afterClosed().subscribe(result => {

    });
  }
}
