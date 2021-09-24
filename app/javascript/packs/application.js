// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/actiontext");
require("jquery");
require("@nathanvda/cocoon");
require("flatpickr");
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "controllers";
import "channels";
import "bootstrap/dist/js/bootstrap.min.js";
import "bootstrap/dist/css/bootstrap.min.css";
import "trix/dist/trix.css";
import "trix/dist/trix.js";
import "flatpickr/dist/flatpickr.css";
import flatpickr from "flatpickr";

document.addEventListener("turbolinks:load", () => {
  $('[data-tooltip-display="true"]').tooltip(),
  flatpickr("[class='flatpickr']", { dateFormat: "d/m/Y" })
})

window.Rails = Rails;

Rails.start();
Turbolinks.start();
ActiveStorage.start();
