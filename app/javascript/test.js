document.addEventListener("turbolinks:load", function () {

  $(".photo").on("click", function(){
    $(this).next(".expansion").fadeIn(700);
    }
  );

  $(".close-btn").on("click", function(){
    $(".expansion").fadeOut(700);
    }
  );

});