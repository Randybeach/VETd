import { Component, OnInit } from '@angular/core';
import { Mentor } from 'src/app/models/mentor';
import { Mentee } from 'src/app/models/mentee';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-mentee-profile',
  templateUrl: './mentee-profile.component.html',
  styleUrls: ['./mentee-profile.component.css']
})
export class MenteeProfileComponent implements OnInit {
  mentor = new Mentor();
  mentee = new Mentee();


  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute

  ) { }

  ngOnInit() {
    this.getMentee();
    this.getMentor();
  }

  getMentee() {
    // call auth service
  }
  getMentor() {
    // call auth service
  }

}
