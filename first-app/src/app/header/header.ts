import { Component, EventEmitter, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './header.html',
  styleUrls: ['./header.css']
})
export class HeaderComponent {
  city = '';

  @Output() searchCity = new EventEmitter<string>();

  onSearch() {
    this.searchCity.emit(this.city);
  }
}
