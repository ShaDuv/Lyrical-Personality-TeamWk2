// let navbar = $(".navbar");
//
// $(window).scroll(function () {
//   // get the complete hight of window
//   let oTop = $(".section-3").offset().top - window.innerHeight;
//   if ($(window).scrollTop() > oTop) {
//     navbar.addClass("sticky");
//   } else {
//     navbar.removeClass("sticky");
//   }
// });
// console.log("something in the way");
$(document).ready(function() {
  $(".fa").click(function(event){
    event.preventDefault();
    $(".load").fadeIn();
    var load = setTimeout(function(){loading()}, 20000);
  });
});

function loading() {
  $(".load").hide() ;
  // $(".search-area").slideDown();
  clearTimeout(load);
};
