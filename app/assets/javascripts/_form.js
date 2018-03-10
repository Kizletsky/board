 // FOR TAGS IN POST FORM
$(document).on("turbolinks:load", function() {


  $("button.all-tags").on("click", function(){
    var currTags = $("#post_current_tags").val().split(",");
      currTags.forEach(function(element) {
        $("ul.all-tags li").filter(function() {
          console.log("this.text = " + $(this).text());
          console.log("element value = " + element);

          return $(this).text().match(element);
        }).prop("checked", true);
      });
  });
  
  $("ul.all-tags").on("click", "li", function(){
    var tagRegExp = "(^|,)" + $(this).text() + "($|,)";
    if($("#post_current_tags").val().search(tagRegExp) == -1)
    {
      addTag($(this).text());
    }
    else {
      removeTag($(this).text());
    };
  });

  // for create new tag btn
  $("#tag-link").on("click", function(e) {
    e.preventDefault();
    var tagName = $("#tag-field").val().replace(/ /g, "");
    // send ajax for creating a new tag
    $.ajax({
      type: "POST",
      url: "/tags",
      data: {name: tagName},
      success: function(data, textStatus, jqXHR){
        // if success add new tag to hidden field and append it to the dropbox
        addTag(data.name);
        $("ul.all-tags").append("<li><input type='checkbox' checked>" + data.name + "</li>");
      },
      error: function(jqXHR, textStatus, errorThrown){
        console.log("ERROR: " + errorThrown);
      }
    });
  });
  // for deleting tag from post
  $(".current-tags").on("click", ".tag", function(){
    removeTag($(this).text());
  });




  function addTag(name){
    $("#post_current_tags").val(function(){
      return $(this).val().concat(name, ",");
    });
    $(".current-tags").append("<span class='badge badge-pill badge-primary tag'>" + name + "</span>");
  };

  function removeTag(name){
    // tag that we are looking for may begin with "," or not, need use regexp to handle this
    var tagRegExp = "(^|,)" + name + "($|,)";
    // getting first char ( ','  or   beginning of string)
    var index = $("#post_current_tags").val().search(tagRegExp);
    var firstChar = $("#post_current_tags").val().charAt(index);
    // removing tag from hidden field
    $("#post_current_tags").val(function(){
      return $(this).val().replace(new RegExp(tagRegExp, "g"), firstChar == "," ? "," : "");
    });
    // and from view
    var tagToRemove = $(".tag").filter(function() {
      return $(this).text().match(new RegExp(tagRegExp, "g"));
    });
    $(tagToRemove).remove();
  };
});
