Date.prototype.day_or_night = function() {
    var h = this.getDay();
    if (h > 18) {
        return "night";
    } else {
        return "day";
    }

}


document.onReady(function(){
  // Your code here

    var foos = new Array();
    foos[0] = "teste";
    foos[1] = "oi";

    $("fim").insert("...");
    foos.each(function(foo,i) {
        $("fim").insert('<br>' + i + foo);
    });
    $("fim").insert("Start", "before");


    $("b1").observe("click", function(e) {
       $("fim").clean();
     //   $("fim").update("hi!"); // .replace replace tudo! (div)
    });

    $("b2").on("click", function(e) {
      $("fim").insert("<p>added..</p>"); // remove(expr)
    });

    $("b3").on("click", function(e) {
        $("fim").first("p").remove(); //update("hoho");
    });

    $$("p").each(function(e,i) {
        e.on("click", function(event){
          this.highlight();
        })
    });


    // $("some_id").update("foo").highlight(); //slide("down");

    $("some_id").on("click", function() {
        this.highlight().slide("up");
    });

    $$(".some_class").each(function(e, i) {
        e.on("click", function(){
        // event.preventDefault();
            this.highlight().slide("up");
        });
        e.highlight();
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
    $("info").insert(c.txt);

    var mumu = {name: "saleen", model: "s7r", hp: 650};
    $("info").insert(onP(mumu.name));



    now = new Date();
    $("info").insert(onP(now.day_or_night()));

    //$("info").doom({oi: "oie"});



});
