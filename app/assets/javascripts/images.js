$(document).on("turbolinks:load", function() {
    function readURL(input) {
      if(input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $(".load-img")
            .attr("src", e.target.result)
            .width(200)
            .height(150);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

    $(".input-img").on("change", function() {
      readURL(this);
    })
});
