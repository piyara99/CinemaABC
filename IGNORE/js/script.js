// Function to update the total price and list of selected seats
function UpdateTotal() {
    const seatPrice = 1000; // Price per seat
    const priceWrapper = document.querySelector('.price-wrapper');
    const checkboxes = document.querySelectorAll('.seatgrid input[type="checkbox"]');

    // Clear existing seat entries
    priceWrapper.innerHTML = '';

    let totalPrice = 0;

    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            totalPrice += seatPrice;

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
    const totalElement = document.querySelector('.ticket-booking-right .price-chart-item-wrapper:last-child h2:last-child');
    totalElement.textContent = `Rs${totalPrice}`;
}
