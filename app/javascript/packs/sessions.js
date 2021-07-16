let adminButton = document.getElementById("admin-button");
let artistButton = document.getElementById("artist-button");
let adminBackButton = document.getElementById("admin-back-button");
let artistBackButton = document.getElementById("artist-back-button");
let welcomeCard = document.getElementById("welcome-card");
let adminCard = document.getElementById("admin-card");
let artistCard = document.getElementById("artist-card");

adminButton.onclick = function() {
  hideWelcomeCard();
  displayAdminCard();
}

artistButton.onclick = function() {
  hideWelcomeCard();
  displayArtistCard();
}

adminBackButton.onclick = function() {
  hideAdminCard();
  displayWelcomeCard();
}

artistBackButton.onclick = function() {
  hideArtistCard();
  displayWelcomeCard();
}

function displayWelcomeCard() { welcomeCard.style.display = "block"; }
function displayAdminCard() { adminCard.style.display = "block"; }
function displayArtistCard() { artistCard.style.display = "block"; }
function hideWelcomeCard() { welcomeCard.style.display = "none"; }
function hideAdminCard() { adminCard.style.display = "none"; }
function hideArtistCard() { artistCard.style.display = "none"; }
