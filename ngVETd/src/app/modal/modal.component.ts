import { SortbyidPipe } from './../pipes/sortbyid.pipe';
import { MentorMentee } from './../models/mentor-mentee';
import { ProfileComponent } from './../components/profile/profile.component';
import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA} from '@angular/material';
import { DialogData } from '../DialogData';
import { Profile } from '../models/profile';
import { ProfileService } from '../services/profile.service';
import { AuthService } from '../services/auth.service';
import { Review } from '../models/review';
import { Message } from '../models/message';
import { throwError } from 'rxjs';
import { log } from 'util';
import { NgForm } from '@angular/forms';



@Component({
  selector: "app-modal",
  templateUrl: "./modal.component.html",
  styleUrls: ["./modal.component.css"]
})
export class ModalComponent implements OnInit {
  profile = null;
  mentees = [];
  jobs = [];
  myProfile = null;
  review = new Review();
  showChat = false;
  message = new Message();
  menteeId = 0;
  mentorId = 0;
  mentorMentee = null;
  messageList = [];
  num = 0;
  resUrl = false;
  admin = null;


  constructor(
    public dialogRef: MatDialogRef<ModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private profileService: ProfileService,
  ) {}

  onNoClick(): void {
    this.dialogRef.close();
  }

  ngOnInit() {
    this.admin = localStorage.getItem('admin')

    this.profile = this.data.profile;
    this.myProfile = this.data.myProfile;
    console.log(this.profile);

    console.log(this.myProfile);

    this.addMenteesOrMentors();

    console.log("in init");
  }
  formatLabel(value: number | null) {
    if (!value) {
      return 0;
    }

    if (value >= 1) {
      return Math.round(value / 5);
    }

    return value;
  }

  removeMentee(p) {
    this.profile = p;
    console.log("trying to remove " + this.profile.firstName);
    this.profileService
      .removeMenteeFromMentorList(this.profile)
      .subscribe(good => {
        console.log("closing window");
        // this.profile = this.profileComp.getProfile();
        // this.profileComp.getListOfMenteesByMentorId(this.profile);
        this.onNoClick();
      });
  }
  addMenteeToMentorMenteeList(p) {
    this.profile = p;
    console.log("added " + this.profile.firstName + " to list");
    this.profileService.addMenteeToMentorList(this.profile).subscribe(
      good => {
        this.onNoClick();
      },
      bad => {
        console.log("error adding mentee");
      }
    );
  }
  addMenteesOrMentors() {
    if (this.profile.mentor != null) {
      //I am a mentee
      this.mentees = this.profile.mentor.mentorMentees;
      this.jobs = this.profile.mentor.jobs;
      console.log(this.jobs);

      this.mentorId = this.profile.mentor.id;
      this.menteeId = this.myProfile.mentee.id;

      console.log(this.mentees);

      for(let i = 0; i < this.mentees.length; i++) {
        console.log('mentee'+this.mentees[i].mentee.id);
        console.log('mentees'+this.mentees[i].mentees.id);
        if(this.mentees[i].mentee.id === this.myProfile.mentee.id){
          console.log('its a match for being a mentee');
          this.num = i;
          console.log(this.mentees[i].id);
          this.mentorMentee = this.mentees[i];


          console.log('message 1')
        }


      }
      this.loadMessages();

    } else {
      //I am a mentor
      this.jobs = this.profile.mentee.jobs;
      console.log(this.jobs);
      this.mentorId = this.myProfile.mentor.id;
      this.menteeId = this.profile.mentee.id;

      this.mentees = this.myProfile.mentor.mentorMentees;

      // console.log(this.mentees.length);
      // console.log(this.myProfile.mentor.id);

      for(let i = 0; i < this.mentees.length; i++) {
        console.log('mentee id'+this.mentees[i].mentee.id);
        if(this.mentees[i].mentee.id === this.profile.mentee.id){
          this.mentorMentee = this.mentees[i];
          this.num = i;

          console.log('its a match');

          }
        console.log('id '+this.mentees[i].id);



      }
      this.loadMessages();
    }
  }
  chat() {
    this.showChat = true;
    console.log("new message");
  }
  submitMessage() {
    this.message.profileId = this.myProfile.id;
    this.message.mentorMentee = this.mentorMentee;
    console.log(this.message);
    this.message.createdAt = Date.now().toString();
    this.messageList.push(this.message.text);
    console.log(this.message.createdAt);



    this.profileService.submitMessage(this.message, this.profile.id).subscribe(
      good => {
        console.log(good);
        this.addMenteesOrMentors();
        console.log(this.messageList);

        }
      );
    this.message = new Message();
    this.showChat = false;

  }

  addReview(form: NgForm) {
    this.review = form.value;
    this.review.profileId = this.profile.id;
    // this.review.reviewer = this.myProfile.user;
    console.log("review", this.review);
    console.log("pid", this.review.profileId);
    // console.log("reviewer", this.review.reviewer);

    this.profileService.addReview(this.review, this.review.profileId).subscribe(
      good => {
        console.log(good);
      },
      bad => {
        console.log("error adding review");

        console.log(bad);
      }
    );
  }
  loadMessages(){
    console.log('loading');

    if(this.profile.mentee !== null){
      for(let i = 0; i < this.myProfile.mentor.mentorMentees.length; i++){


        if(this.profile.mentee.id === this.myProfile.mentor.mentorMentees[i].mentee.id){

            this.messageList = this.myProfile.mentor.mentorMentees[i].messages;

          }
        }
      }else{
        for(let i =0; i < this.profile.mentor.mentorMentees.length; i++){
          if(this.myProfile.mentee.id === this.profile.mentor.mentorMentees[i].mentee.id){
            this.messageList = this.profile.mentor.mentorMentees[i].messages;


        }
      }
    }
  }
  refreshMessages(){

  }
  showResume(){
  console.log("resume");
    this.resUrl = !this.resUrl;
  }


}
