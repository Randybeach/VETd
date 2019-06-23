import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { ProfileService } from 'src/app/services/profile.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  //
  // F E I L D S
  //

  user = new User();
  profile = null;

  constructor(private auth: AuthService, private router: Router, private profileService: ProfileService) {}

  //
  // M E T H O D S
  //

  ngOnInit() {}

  login(form: NgForm) {
    this.user.username = form.value.username;
    this.user.password = form.value.password;
    console.log(this.user.username);

    this.auth.login(this.user.username, this.user.password).subscribe(
      data => {

        this.router.navigateByUrl('profile');
      },
      err => {
        console.error(err);
      }
    );
  }
}
