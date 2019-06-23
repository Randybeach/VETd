import { Injectable } from '@angular/core';
import { catchError, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { User } from '../models/user';
import { environment } from 'src/environments/environment';
import { Mentee } from '../models/mentee';
import { Profile } from '../models/profile';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private baseUrl = environment.baseUrl;

  newUser = new User();

  mentee = new Mentee();
  profile = null;

  constructor(private http: HttpClient) {}

  login(username, password) {
    // Make credentials
    const credentials = this.generateBasicAuthCredentials(username, password);
    // Send credentials as Authorization header (this is spring security convention for basic auth)
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    // create request to authenticate credentials
    return this.http.get(this.baseUrl + 'authenticate', httpOptions).pipe(
      tap(res => {
        localStorage.setItem('credentials', credentials);

        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('AuthService.login(): Error logging in.');
      })
    );
  }

  register(mentee, url) {
    this.mentee = mentee;

    // create request to register a new account
    return this.http.post(this.baseUrl + 'register/' + url, mentee).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('AuthService.register(): error registering user.');
      })
    );
  }

  logout() {
    console.log(sessionStorage.getItem('username'));

    localStorage.removeItem('credentials');
  }

  checkLogin() {
    if (localStorage.getItem('credentials')) {
      return true;
    }
    return false;
  }
  checkAdmin(){
    if(localStorage.getItem('admin')){
      console.log(localStorage.getItem('admin'));

      return true;
    }
    return false;
  }

  generateBasicAuthCredentials(username, password) {
    return btoa(`${username}:${password}`);
  }

  getCredentials() {
    return localStorage.getItem('credentials');
  }

}
