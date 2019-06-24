import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { AuthService } from './services/auth.service';
import { BrowserModule } from '@angular/platform-browser';
import { CarouselModule, IconsModule } from 'angular-bootstrap-md';
import { FormsModule } from '@angular/forms';
import { HomeComponent } from './components/home/home.component';
import { HttpClientModule } from '@angular/common/http';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { NavbarModule, WavesModule } from 'angular-bootstrap-md';
import { NgModule } from '@angular/core';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { RegisterComponent } from './components/register/register.component';
import { MatExpansionModule, MatButtonModule, MatInputModule, MatFormFieldModule, MatIconModule } from '@angular/material';
import { EditComponent } from './components/edit/edit.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AdminComponent } from './components/admin/admin.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { MenteeProfileComponent } from './components/mentee-profile/mentee-profile.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from './material.module';
import { ModalComponent } from './modal/modal.component';
import { MatSelectModule } from '@angular/material/select';


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    LogoutComponent,
    NavigationComponent,
    HomeComponent,
    RegisterComponent,
    EditComponent,
    ProfileComponent,
    AdminComponent,
    MenteeProfileComponent,
    ModalComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule,
    NavbarModule,
    CarouselModule,
    MatExpansionModule,
    MatButtonModule,
    MatInputModule,
    MatFormFieldModule,
    IconsModule,
    WavesModule,
    MatIconModule,
    FontAwesomeModule,
    BrowserModule,
    BrowserAnimationsModule,
    MaterialModule,
    MatSelectModule
  ],
  providers: [AuthService, ProfileComponent],
  bootstrap: [AppComponent],
  entryComponents: [ModalComponent]
})
export class AppModule {}
