$(document).ready(function(){
  $("select")
    .on("change", function(e){
      var isGoal = this.value == "goal";
      $(".form-deadline").toggleClass("hidden", !isGoal);
    }).change();
})
