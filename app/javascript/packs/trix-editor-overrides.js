window.addEventListener("trix-file-accept", function(event) {
  const maxFileSize = 1024 * 20480;
  const file = event.file
  if (file.size > maxFileSize && !file.type.match(/video/).length == 0) {
    event.preventDefault();
    alert("Currently we only support video uploads of up to 20MB.");
  }
})
