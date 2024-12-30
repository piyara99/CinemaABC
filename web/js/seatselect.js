// Function to update the total price and list of selected seats
function UpdateTotal() {
    const seatPrice = 1000; // Price per seat
    const priceWrapper = document.querySelector('.price-wrapper');
    const checkboxes = document.querySelectorAll('.seatgrid input[type="checkbox"]');

    if (!priceWrapper) {
        console.error("Price wrapper element not found.");
        return;
    }

    // Clear existing seat entries
    priceWrapper.innerHTML = '';
    selectedSeats = [];

    let totalPrice = 0;

    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            totalPrice += seatPrice;
            selectedSeats.push(checkbox.id);

            // Create a new entry for the selected seat
            const priceChartItem = document.createElement('div');
            priceChartItem.classList.add('price-chart-item-wrapper');

            priceChartItem.innerHTML = `
                <h3>${checkbox.id}</h3>
                <div class="line"></div>
                <h3>Rs${seatPrice}</h3>
            `;

            // Append the new entry inside the price-wrapper
            priceWrapper.appendChild(priceChartItem);
        }
    });

    // Update the total price
    const totalElement = document.querySelector(
        '.ticket-booking-right .price-chart-item-wrapper:last-child h2:last-child'
    );

    if (totalElement) {
        totalElement.textContent = `Rs${totalPrice}`;
    } else {
        console.error("Total price element not found.");
    }
}

// Fetch seat availability from the server
async function fetchSeatAvailability() {
    try {
        const response = await fetch('http://localhost:8080/app6cinema/SeatAvailabilityServlet');
        const seatData = await response.json();
        updateSeatAvailability(seatData);
    } catch (error) {
        console.error("Error fetching seat data:", error);
    }
}

function updateSeatAvailability(seatData) {
    const allSeats = document.querySelectorAll('input[type="checkbox"]');
    
    allSeats.forEach(seat => {
        const seatId = seat.id;
        
        if (seatData[seatId] === "available") {
            seat.disabled = false; 
            // Enable seat if it's available
        } else if (seatData[seatId] === "occupied") {
            seat.disabled = true;   // Disable seat if it's occupied
            seat.checked = false; 
            seat.parentElement.style.backgroundColor = "red";
        } else if (seatData[seatId] === "onhold") {
            seat.disabled = true;   // Disable seat if it's on hold
            seat.checked = false;   // Ensure it's unchecked
        }
    });
}

let selectedSeats = [];

function proceedToCheckout() {
    if (selectedSeats.length === 0) {
        alert("No seats selected.");
        return;
    }

    // Redirect to the JSP with selected seats as query parameters
    const seatIds = selectedSeats.join(',');
    window.location.href = `/app6cinema/checkout.jsp?selectedSeats=${seatIds}`;
}





// Update selectedSeats array when checkboxes are toggled
document.querySelectorAll('input[type="checkbox"]').forEach(seat => {
    seat.addEventListener('change', event => {
        const seatId = event.target.id;

        if (event.target.checked) {
            selectedSeats.push(seatId); // Add selected seat ID
        } else {
            selectedSeats = selectedSeats.filter(id => id !== seatId); // Remove deselected seat ID
        }
    });
});

// Call this function to fetch data and update seat availability when the page loads
document.addEventListener("DOMContentLoaded", fetchSeatAvailability);
function loadReservationData() {
    // Retrieve session data (userId and selectedSeats)
    const userId = "${sessionScope.userId}"; // Get userId from session
    const seatIds = "${sessionScope.selectedSeats}".split(','); // Get selected seat IDs from session

    // Assuming seatIds is an array of selected seat IDs
    selectedSeats = seatIds;

    // Update the UI with the selected seats
    const selectedSeatsList = document.querySelector('#selected-seats');
    selectedSeats.forEach(seatId => {
        const seatItem = document.createElement('div');
        seatItem.classList.add('selected-seat');
        seatItem.textContent = seatId; // Display seat ID
        selectedSeatsList.appendChild(seatItem);
    });

    // Update the total charge (assuming price per seat is 1000)
    const seatPrice = 1000;
    const totalPrice = selectedSeats.length * seatPrice;
    const totalElement = document.querySelector('#total-amount');
    totalElement.textContent = `LKR ${totalPrice.toFixed(2)}`;
}

function selectPaymentGateway(gateway) {
    selectedPaymentGateway = gateway;

    if (gateway === "PayPal") {
        document.getElementById("paypalForm").style.display = "block";
        document.getElementById("visaMastercardForm").style.display = "none";
    } else if (gateway === "Visa/Mastercard") {
        document.getElementById("visaMastercardForm").style.display = "block";
        document.getElementById("paypalForm").style.display = "none";
    }

    console.log("Selected Payment Gateway: " + selectedPaymentGateway);
}

