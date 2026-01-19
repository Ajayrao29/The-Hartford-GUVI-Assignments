import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home-list',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home-list.html',
  styleUrls: ['./home-list.css']
})
export class HomeListComponent {

  homes = [
    {
      name: 'Acme Fresh Start Housing',
      city: 'Chicago, IL',
      image: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&auto=format&fit=crop'
    },
    {
      name: 'A113 Transitional Housing',
      city: 'Santa Monica, CA',
      image: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&auto=format&fit=crop'
    },
    {
      name: 'Warm Beds Housing Support',
      city: 'Juneau, AK',
      image: 'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?w=800&auto=format&fit=crop'
    },
    {
      name: 'Homesteady Housing',
      city: 'Chicago, IL',
      image: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800&auto=format&fit=crop'
    },
    {
      name: 'Happy Homes Group',
      city: 'Gary, IN',
      image: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop'
    },
    {
      name: 'Hopeful Apartment Group',
      city: 'Oakland, CA',
      image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&auto=format&fit=crop'
    },
    {
      name: 'Seriously Safe Towns',
      city: 'Oakland, CA',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8dT7ou0UQYhdsekkE01_wntdTq2X9xRqmtg&s'
    },
    {
      name: 'Hopeful Housing Solutions',
      city: 'Oakland, CA',
      image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&auto=format&fit=crop'
    },
    {
      name: 'Capital Safe Towns',
      city: 'Portland, OR',
      image: 'https://media.istockphoto.com/id/1137607008/photo/houses-in-the-alphabet-historic-district-portland-oregon-usa.jpg?s=612x612&w=0&k=20&c=byD4Fhwk2fT8ZlHhLgPR5R0D70QPBxeH1NqnVCwAKww='
    }
  ];

  filteredHomes = this.homes;

  filterByCity(city: string) {
    if (!city) {
      this.filteredHomes = this.homes;
      return;
    }

    this.filteredHomes = this.homes.filter(home =>
      home.city.toLowerCase().includes(city.toLowerCase())
    );
  }
}
