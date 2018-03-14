  // FOR TAGS IN POST FORM
  $(document).on("turbolinks:load", function() {

    // clear input
    $("#tag-field").val("");
    // when dropdown is clicked, refresh all checkboxes
    $("button.all-tags").on("click", function() {
      $("li.tag input:checkbox").each(function() {
        var isChecked
        containTag( $(this).val() ) == -1 ? isChecked = false : isChecked = true;
        $(this).prop("checked", isChecked);
      });
    });
    // add tag to current post tags or remove when checkbox is clicked
    $("ul.all-tags").on("click", "input:checkbox", function(){
      var tagName = $(this).val();
      containTag( tagName ) == -1 ? addTag(tagName) : removeTag(tagName);
    });
    // validate input
    $("#tag-field").on("keyup", function() {
        var fieldRegExp = /^[^,| ]{1,30}$/gi
        if(fieldRegExp.test($(this).val())){
          $(this).removeClass("invalid").addClass("valid");
          $("#tag-link").show();
        }else{
          $(this).removeClass("valid").addClass("invalid");
          $("#tag-link").hide();
        }
    });

    // for create new tag btn
    $("#tag-link").on("click", function(e) {
      e.preventDefault();
      var tagName = $("#tag-field").val();
      // send ajax to create a new tag
      $.ajax({
        type: "POST",
        url: "/tags",
        data: {name: tagName},
        success: function(data){
          // remove all errors from view
          $(".tag-errors").empty();
          // add new tag to current tags and append it to dropdown
          addTag(data.name);
          $("ul.all-tags").append("<li class='tag'>" +
                                  "<input type='checkbox' value=".concat("'", data.name, "'", ">") +
                                  "<label>" + data.name + "</label>" +
                                  "</li>");

        },
        error: function(xhr){
          // remove all errors from view
          $(".tag-errors").empty();
          var errors = $.parseJSON(xhr.responseText).errors
          errors.forEach(function(error) {
            $(".tag-errors").append("<li class='alert alert-danger'>" + error + "</li>");
          });
        }
      });
    });
    // for deleting tag from post
    $(".current-tags").on("click", "span.tag", function(){
      removeTag($(this).text());
    });
    // add tag to current tags hidden field and to current tags span container
    function addTag(name){
      $("#post_current_tags").val(function(){
        return $(this).val().concat(name, ",");
      });
      $(".current-tags").append("<span class='badge badge-pill badge-primary tag'>" + name + "</span>");
    };

    function removeTag(name){
      // getting first char ( ','  or   beginning of string)
      var firstChar = $("#post_current_tags").val().charAt(containTag(name));
      // removing tag from hidden field
      $("#post_current_tags").val(function(){
        return $(this).val().replace(tagRegExp(name), firstChar == "," ? "," : "");
      });
      // and from view
      var tagToRemove = $("span.tag").filter(function() {
        return $(this).text().match(tagRegExp(name));
      });
      $(tagToRemove).remove();
    };

    function tagRegExp(name){
      // tag that we are looking for may begin with "," or not, need use regexp to handle this
      var tagRegExp = "(^|,)" + name + "($|,)";
      return new RegExp(tagRegExp, "g");
    }

    function containTag(name){
      // search in current tags by name, if it doesn't exists return -1 else return first char index
      return $("#post_current_tags").val().search(tagRegExp(name));
    }

});
