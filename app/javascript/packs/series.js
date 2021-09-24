let artistDropdown = document.getElementById("series_artist_id");
let artworkDropdown = document.getElementById("series_artwork_ids");

artistDropdown.onchange = function() {
  let artistId = this.value;
  if (artistId === "") {
    removeOptions(artworkDropdown);
    return;
  }
  Rails.ajax({
    url: `/artworks?artist_id=${artistId}`,
    type: "get",
    data: "",
    success: function(data) { repopulateArtworkDropdown(data) },
    error: function(data) {}
  })
}

function repopulateArtworkDropdown(data) {
  removeOptions(artworkDropdown);
  addOptions(artworkDropdown, data);
}

function removeOptions(dropdown) {
  while (dropdown.options.length > 0) {
    dropdown.remove(0);
  }
}

function addOptions(dropdown, options) {
  for (option in options) {
    let newOption = new Option(options[option].title, options[option].id);
    dropdown.add(newOption, undefined)
  }
}
