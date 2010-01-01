Date.prototype.day_or_night = function() {
    var h = this.getDay();
    if (h > 18) {
        return "night";
    } else {
        return "day";
    }

}

jQuery.fn.doom = function() {
    var o = $(this[0]);
    //o.empty();
    var args = arguments[0] || {}
    return args
}

$(document).ready(function(){
  // Your code here


// $('a').click(function(event){
//   alert('As you can see, the link no longer took you to jquery.com');
    //   event.preventDefault();
    // });

    var foos = new Array();
    foos[0] = "teste";
    foos[1] = "oi";

    $('#fim').append("...");
    for (var name in foos) {
        $('#fim').append(foos[name]);
    }
    $('#fim').prepend("Start");


    $('#b1').click(function(e) {
        $('#fim').empty(); // remove(expr)
    });

    $('#b2').click(function(e) {
        $('#fim').append("<p>added..</p>"); // remove(expr)
    });

    $('#b3').click(function(e) {
        $('#fim').find(":first").remove();
    });

    $('p').click(function(event){
        event.preventDefault();
        $(this).hide('slow');
    });


    $('#some_id').click(function(event){
        event.preventDefault();
        $(this).slideDown('slow');
    });

    $('.some_class').click(function(event){
        event.preventDefault();
        $(this).slideUp('slow');
    });

    function onP(txt) {
        return "<p>" + txt + "</p>"
    }

    function Car(name, model, hp) {
        this.name = name;
        this.model = model;
        this.hp = hp;
        this.txt = onP(this.name + " (" + this.model +  "): " + this.hp)
    }

    c = new Car("ferrari", "maranello", 650);
    $('#info').append(c.txt);

    var mumu = {name: "saleen", model: "s7r", hp: 650};
    $('#info').append(onP(mumu.name));



    now = new Date();
    $('#info').append(onP(now.day_or_night()));

    $('#info').doom({oi: "oie"});



});
