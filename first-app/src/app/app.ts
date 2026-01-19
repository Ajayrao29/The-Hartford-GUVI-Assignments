import { Component } from '@angular/core';
import { HeaderComponent } from './header/header';
import { HomeListComponent } from './home-list/home-list';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [HeaderComponent, HomeListComponent],
  templateUrl: './app.html',
  styleUrls: ['./app.css']
})
export class AppComponent {}
