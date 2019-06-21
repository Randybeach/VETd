import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  constructor(private auth: AuthService) {}

  ngOnInit() {}
  //
  // M E T H O D S
  //
  isLoggedIn() {
    return this.auth.checkLogin();
  }
}
