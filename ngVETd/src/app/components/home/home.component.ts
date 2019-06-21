import { Component, OnInit } from "@angular/core";
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.css"]
})
export class HomeComponent implements OnInit {
  //
  // F E I L D S
  //

    reviewList = [
      {
      reviewTitle: 'Title 1',
      reviewText: 'Wonderful experience with VETd!',
      reviewStars: 4,
      img: 'assets/blank.jpg'
      },
      {
      reviewTitle: 'Title 2',
      reviewText: 'Wonderful experience with VETd! Superb',
      reviewStars: 4,
      img: 'assets/blank.jpg'
      },
      {
      reviewTitle: 'Title 3',
      reviewText: 'Wonderful experience with VETd! Highly recommended!',
      reviewStars: 5,
      img: 'assets/blank.jpg'
      }
    ];

  // event_list = [
  //   {
  //     event:' Event 1',
  //     eventLocation:'Bangalore',
  //     eventDescription:'Bangalore event',
  //     img: 'https://picsum.photos/900/500?random&t=1',
  //     eventStartDate: new Date('2019/07/20'),
  //     eventEndingDate: new Date('2019/07/24')
  //   },
  //    {
  //     event:' Event 2',
  //     eventLocation:'Dubai',
  //     eventDescription:'Dubai event',
  //     img: 'https://picsum.photos/900/500?random&t=3',
  //     eventStartDate: new Date('2019/07/28'),
  //     eventEndingDate: new Date('2019/07/30')
  //   },
  //    {
  //     event:' Event 3',
  //     eventLocation:'New York',
  //     eventDescription:'NewYork event',
  //     img: 'https://picsum.photos/900/500?random&t=4',
  //     eventStartDate: new Date('2020/07/20'),
  //     eventEndingDate: new Date('2020/07/24')
  //   },
  //    {
  //     event:' Event 4',
  //     eventLocation:'Singapore',
  //     eventDescription:'Singapore event',
  //     img: 'https://picsum.photos/900/500?random&t=6',
  //     eventStartDate: new Date('2019/07/20'),
  //     eventEndingDate: new Date('2019/07/24')
  //   },
  //   {
  //     event:' Event 5',
  //     eventLocation:'Berlin',
  //     eventDescription: 'Berlin event',
  //     img: 'https://picsum.photos/900/500?random&t=7',
  //     eventStartDate: new Date('2019/07/10'),
  //     eventEndingDate: new Date('2019/08/14')
  //   },
  //   {
  //     event:' Event 6',
  //     eventLocation:'Mumbai',
  //     eventDescription:'Mumbai event',
  //     img: 'https://picsum.photos/900/500?random&t=8',
  //     eventStartDate: new Date('2019/08/12'),
  //     eventEndingDate: new Date('2019/09/01')
  //   },
  //   {
  //     event:' Event 7',
  //     eventLocation:'Barcelona',
  //     eventDescription:'Barcelona event',
  //     img: 'https://picsum.photos/900/500?random&t=6',
  //     eventStartDate: new Date('2019/09/20'),
  //     eventEndingDate: new Date('2019/09/30')
  //   },
  // ];
  reviews =  this.reviewList;

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  //
  // M E T H O D S
  //
  ngOnInit() {}

  addMentor() {
    this.router.navigateByUrl("/register/mentor");
  }
  addMentee() {
    this.router.navigateByUrl("/register/mentee");
  }
}
