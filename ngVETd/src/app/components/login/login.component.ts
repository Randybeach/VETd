import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  user = new User();

  constructor(private auth: AuthService, private router: Router) {}

  ngOnInit() {}

  login(form: NgForm) {
    this.user.username = form.value.username;
    this.user.password = form.value.password;
    console.log(this.user.username);

    this.auth.login(this.user.username, this.user.password).subscribe(
      data => {
        this.router.navigateByUrl('todo');
      },
      err => {
        console.error(err);
      }
    );
  }
}
