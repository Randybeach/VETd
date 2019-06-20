import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { Router, ActivatedRoute } from '@angular/router';
import { Mentor } from 'src/app/models/mentor';
import { Mentee } from 'src/app/models/mentee';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
//
// F E I L D S
//
  newUser = new User();
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

  register(form: NgForm) {
    console.log(this.newUser.email);

    this.auth.register(this.newUser).subscribe(
      data => {
        console.log('RegisterComponent.register(): user registered.');
        this.auth.login(this.newUser.username, this.newUser.password).subscribe(
          next => {
            console.log(
              'RegisterComponent.register(): user logged in, routing to /CHANGEME.'
            );
            this.router.navigateByUrl('/CHANGEME');
          },
          error => {
            console.error('RegisterComponent.register(): error logging in.');
          }
        );
      },
      err => {
        console.error('RegisterComponent.register(): error registering.');
        console.error(err);
      }
    );
  }
}
