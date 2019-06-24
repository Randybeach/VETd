import { environment } from 'src/environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Sector } from '../models/sector';
import { AuthService } from './auth.service';
import { Job } from '../models/job';
import { Profile } from '../models/profile';
import { User } from '../models/user';

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

    return this.http.put<Profile>(this.url + '/remove/jobs', job, {
      headers: myHeaders
    });
  }

  getProfile() {
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
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };

    return this.http.get<User[]>(this.url + '/search/' + keyword, {
      headers: myHeaders
    });
  }
  getListOfMenteesWithChosenJobs() {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.get<Profile[]>(this.url + '/mentee/job', {headers: myHeaders});
  }
  getMentorsByMenteeId(id): Observable<Profile[]> {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    console.log('In profile service for mentor list by mentee id');
    console.log(this.http.get<Profile[]>(this.url + '/mentee/' + id + '/mentor', {headers: myHeaders}));
    return this.http.get<Profile[]>(this.url + '/mentee/' + id + '/mentor', {headers: myHeaders});
  }

  getMenteesByMentorId(id): Observable<Profile[]> {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    console.log('In profile service for mentee list by mentor id');
    console.log(this.http.get<Profile[]>(this.url + '/mentor/' + id + '/mentee', {headers: myHeaders}));
    return this.http.get<Profile[]>(this.url + '/mentor/' + id + '/mentee', {headers: myHeaders});
  }

  addMenteeToMentorList(profile) {
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };
    return this.http.put<Profile[]>(this.url + '/mentormentee', profile, {headers: myHeaders});
  }

  removeMenteeFromMentorList(profile){
    const myHeaders = {
      'X-Requested-With': 'XMLHttpRequest',
      Authorization: 'Basic ' + this.auth.getCredentials(),
      'Content-Type': 'application/json'
    };

  }
}
