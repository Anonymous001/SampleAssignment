var makeblock = function (x, y) {
    size(300,300);
    fill(255, 235, 153);
    noStroke();
    beginShape ();
        fill(x-100,x-50,x-100);
        stroke(0, 0, 0);
        strokeWeight(0.11);
        rect(x,y,25,20);
        strokeWeight(0.9);
        stroke(59, 235, 235);
        vertex(x+198,y+-356);
        vertex(x+-102,y+260);
    endShape ();
};
var circle = function(x, y) {
    fill(255, 255, 255);
    
};
for (var i = 0; i < 16; i+=1) {
    var z = i*25;
    for (var a = 0; a < 20; a+=1){
        var b = a*20;
        makeblock(z+0,b+0);
    }
}
