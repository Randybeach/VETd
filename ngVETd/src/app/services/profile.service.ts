<<<<<<< HEAD
import { environment } from "src/environments/environment";
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Sector } from "../models/sector";
import { AuthService } from "./auth.service";
import { Job } from "../models/job";
import { Profile } from "../models/profile";
import { Mentor } from "../models/mentor";
import { Mentee } from "../models/mentee";
import { User } from "../models/user";
=======
import { IconsModule } from 'angular-bootstrap-md';
import { environment } from 'src/environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Sector } from '../models/sector';
import { AuthService } from './auth.service';
import { Job } from '../models/job';
import { Profile } from '../models/profile';
import { Mentor } from '../models/mentor';
import { Mentee } from '../models/mentee';
import { User } from '../models/user';
>>>>>>> f06907e3ea4fe74ea5181ca2536f745cf16d8459

@Injectable({
  providedIn: 'root'
})
export class ProfileService {
  //
  // F E I L D S
  //
  private url = environment.baseUrl + 'api';
  constructor(private http: HttpClient, private auth: AuthService) {}
  //
  // M E T H O D S
  //
  getSectors(): Observable<Sector[]> {
    const credentials = this.auth.getCredentials();
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials()
    };
    return this.http.get<Sector[]>(this.url + '/sectors', {
      headers: myHeaders
    });
  }

  getJobs(): Observable<Job[]> {
    const credentials = this.auth.getCredentials();
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials()
    };
    return this.http.get<Job[]>(this.url + '/jobs', { headers: myHeaders });
  }

  getUsers(): Observable<User[]> {
    const credentials = this.auth.getCredentials();
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials()
    };
    return this.http.get<User[]>(this.url + '/users', { headers: myHeaders });
  }

  addJobs(newJobs: Job[]) {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.put<Job[]>(this.url + '/add/jobs', newJobs, {
      headers: myHeaders
    });
  }

  update(editProfile) {
    // const upUrl = this.url + "/" + updateTodo.id;
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.put<Profile>(this.url + '/profile', editProfile, {
      headers: myHeaders
    });
  }

  removeJob(job) {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };

<<<<<<< HEAD
    return this.http.put<Profile>(this.url + "/remove/jobs", job, {
=======
    return this.http.put<Profile>(this.url + '/remove/jobs', job, {
>>>>>>> f06907e3ea4fe74ea5181ca2536f745cf16d8459
      headers: myHeaders
    });
  }

  getProfile() {
<<<<<<< HEAD
=======
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };

    return this.http.get<Profile>(this.url + '/profile', {
      headers: myHeaders
    });
  }

  searchUsers(keyword) {
>>>>>>> f06907e3ea4fe74ea5181ca2536f745cf16d8459
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };

    return this.http.get<User[]>(this.url + '/search/' + keyword, {
      headers: myHeaders
    });
  }
<<<<<<< HEAD

  searchUsers(keyword) {
    const myHeaders = {
      "X-Requested-With": "XMLHttpRequest",
      Authorization: "Basic " + this.auth.getCredentials(),
      "Content-Type": "application/json"
    };

    return this.http.get<User[]>(this.url + "/search/" + keyword, {
      headers: myHeaders
    });
=======
  getListOfMenteesWithChosenJobs() {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.get<Profile[]>(this.url + '/mentee/job', {headers: myHeaders});
  }
  getMenteesByMentorId(id: number) {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.get<Profile[]>(this.url + '/mentor/' + id + '/mentee', {headers: myHeaders});
  }

  addMenteeToMentorList(profile) {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.put<Profile[]>(this.url + '/mentormentee', profile, {headers: myHeaders});
>>>>>>> f06907e3ea4fe74ea5181ca2536f745cf16d8459
  }
}
