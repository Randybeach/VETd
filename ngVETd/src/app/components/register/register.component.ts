import { Location } from './../../models/location';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { Router, ActivatedRoute } from '@angular/router';
import { Mentor } from 'src/app/models/mentor';
import { Mentee } from 'src/app/models/mentee';
import { Profile } from 'src/app/models/profile';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  //
  // F E I L D S
  // //
  // user: User = null;
  newUser = new User();
  newProfile = new Profile();
  newLocation = new Location();
  newMentor = new Mentor();
  newMentee = new Mentee();

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {}
  //
  // M E T H O D S
  //
  ngOnInit() {}

  register(form1: NgForm, form2: NgForm, form3: NgForm) {
    let url = this.router.url;
    url = url.substring(url.length - 6);
    console.log(url);
    this.newUser = form1.value;
    this.newUser.role = 'user';
    this.newUser.enabled = true;

    this.newProfile = form2.value;
    this.newLocation = form3.value;

    this.newProfile.location = this.newLocation;
    this.newProfile.user = this.newUser;
    this.newMentee.profile = this.newProfile;

    this.auth.register(this.newProfile, url).subscribe(
      data => {
        console.log('RegisterComponent.register(): user registered.');
        this.auth.login(this.newUser.username, this.newUser.password).subscribe(
          next => {
            console.log(
              'RegisterComponent.register(): user logged in, routing to /CHANGEME.'
            );
            this.newUser = new User();
            this.newProfile = new Profile();
            this.newLocation = new Location();
            this.newMentor = new Mentor();
            this.newMentee = new Mentee();
            console.log('going to profile');
            this.router.navigateByUrl('/profile');
          },
          error => {
            console.error('RegisterComponent.register(): error logging in.');
          }
        );
      },
      err => {
        this.newUser = new User();
        this.newProfile = new Profile();
        this.newLocation = new Location();
        this.newMentor = new Mentor();
        this.newMentee = new Mentee();
        console.error('RegisterComponent.register(): error registering.');
        console.error(err);
      }
    );
  }
}
