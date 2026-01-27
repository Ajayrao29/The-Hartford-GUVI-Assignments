//Dynamic Farm House Booking Form using JavaScript

// Get form elements
const form = document.getElementById('bookingForm');
const checkinInput = document.getElementById('checkin');
const checkoutInput = document.getElementById('checkout');
const roomsInput = document.getElementById('rooms');
const summaryDiv = document.getElementById('summary');
const totalNightsSpan = document.getElementById('totalNights');
const totalCostSpan = document.getElementById('totalCost');

// Price per room per night
const PRICE_PER_NIGHT = 2000;

// Set minimum date to today
const today = new Date().toISOString().split('T')[0];
checkinInput.setAttribute('min', today);
checkoutInput.setAttribute('min', today);

// Calculate and display booking summary
function calculateSummary() {
  const checkin = new Date(checkinInput.value);
  const checkout = new Date(checkoutInput.value);
  const rooms = parseInt(roomsInput.value) || 1;

  if (checkinInput.value && checkoutInput.value) {
    const nights = Math.ceil((checkout - checkin) / (1000 * 60 * 60 * 24));
    
    if (nights > 0) {
      const totalCost = nights * rooms * PRICE_PER_NIGHT;
      totalNightsSpan.textContent = nights;
      totalCostSpan.textContent = totalCost.toLocaleString('en-IN');
      summaryDiv.style.display = 'block';
    } else {
      summaryDiv.style.display = 'none';
    }
  }
}

// Update checkout min date when checkin changes
checkinInput.addEventListener('change', function() {
  const checkinDate = new Date(this.value);
  checkinDate.setDate(checkinDate.getDate() + 1);
  const minCheckout = checkinDate.toISOString().split('T')[0];
  checkoutInput.setAttribute('min', minCheckout);
  
  // Reset checkout if it's before new checkin
  if (checkoutInput.value && checkoutInput.value <= this.value) {
    checkoutInput.value = '';
  }
  
  calculateSummary();
});

// Recalculate when checkout or rooms change
checkoutInput.addEventListener('change', calculateSummary);
roomsInput.addEventListener('input', calculateSummary);

// Form submission
form.addEventListener('submit', function(e) {
  e.preventDefault();
  
  // Validate dates
  const checkin = new Date(checkinInput.value);
  const checkout = new Date(checkoutInput.value);
  
  if (checkout <= checkin) {
    alert('Check-out date must be after check-in date!');
    return;
  }
  
  // Get form data
  const formData = {
    username: document.getElementById('username').value,
    email: document.getElementById('email').value,
    phone: document.getElementById('phone').value,
    age: document.getElementById('age').value,
    address: document.getElementById('address').value,
    checkin: checkinInput.value,
    checkout: checkoutInput.value,
    guests: document.getElementById('guests').value,
    rooms: roomsInput.value,
    requests: document.getElementById('requests').value,
    totalNights: totalNightsSpan.textContent,
    totalCost: totalCostSpan.textContent
  };
  
  // Create WhatsApp message
  const message = `Hi, I would like to book the farmhouse!

*Personal Details:*
Name: ${formData.username}
Email: ${formData.email}
Phone: ${formData.phone}

*Booking Details:*
Check-in: ${formData.checkin}
Check-out: ${formData.checkout}
Nights: ${formData.totalNights}
Guests: ${formData.guests}
Rooms: ${formData.rooms}
Total Cost: ₹${formData.totalCost}

Special Requests: ${formData.requests || 'None'}`;

  // Open WhatsApp with booking details
  const whatsappURL = `https://wa.me/9392972552?text=${encodeURIComponent(message)}`;
  window.open(whatsappURL, '_blank');
  
  // Show confirmation
  alert('Booking form submitted! Opening WhatsApp to confirm your booking.');
});
