//modeled after doodle jump, and all credit (excluding code)

//belongs to lima sky

//download doodle jump now for your mobile device!!!





/*****

 *** Doodle Jump as made by Nordituck

 * 

 * 

 *****/





/* 

-=-=-=-=-=-=-=-=-=-=-

Use left/right arrow keys to move

Up arrow to shoot

Avoid monsters, or shoot and jump on them

Collect powerups

Jump as high as you can!

*/





/* WARNING! -----

Game may not work as desired if you play with these variables*/ 

var terminal_velocity=4;

var gravity=0.15;

/*--------*/

 

frameRate(60);

 

var keyDown=[6];

var star=getImage("space/star");

var gameScore=0;

 

 

 

//for all the little lovable doodle monsters 

var Monster = function(x,y,type,enviroment){

    this.type=type; //kind of monster

    this.x=x; //x coord

    this.y=y; //y coord

    this.x_veloc=0; //velocities

    this.y_veloc=0;

    this.facing=1; //is it facing left(-1) or right(1)

    this.env=enviroment; //the level it's currently in

    

    

    switch(this.type){

        //blue floaty monster

        case 1: 

            this.w=25;

            this.h=30;

            this.x_veloc=2;

            break;

        //green jumpy monster

        case 2:

            this.w=55;

            this.h=40;

            break;

        default:

            break;

    }

    

};

//draw 'em

Monster.prototype.display=function(){

	switch(this.type){

		//blue

		case 1:

			fill(0, 98, 255);

			pushMatrix();

			translate(this.x+this.w/2,this.y+this.h/2);

			scale(-this.facing,1);

			translate(-this.w/2,-this.h/2);

			rect(0,0,this.w,this.h,6);

			strokeWeight(0.3);

			arc(this.w/2+0.5,5,this.w-1,15,-180,0);

			arc(5,this.h,5,8,0,180);

			arc(20,this.h,5,8,0,180);

			strokeWeight(1);

			fill(207, 193, 37);

			ellipse(9,10,12,12);

			ellipse(9,10,1,1);

			fill(95, 72, 150);

			arc(3,19,5,8,0,180);

			arc(8,19,5,8,0,180);

			arc(13,19,5,8,0,180);

			line(1,19,17,19);

			popMatrix();

			break; 

		//green

		case 2:

			fill(47, 120, 64);  

			ellipse(this.x+(this.w*0.2),this.y+(this.h*1.04),4,6);

			ellipse(this.x+(this.w*0.4),this.y+(this.h*1.04),4,6);

			ellipse(this.x+(this.w*0.6),this.y+(this.h*1.04),4,6);

			ellipse(this.x+(this.w*0.84),this.y+(this.h*1.04),4,6);

			rect(this.x+(this.w*0.1),this.y+(this.h*0.4),this.w*0.8,this.h*0.6,10);

			fill(235, 242, 177);

			ellipse(this.x+(this.w*0.3),this.y+(this.h*0.83),6,6);

			ellipse(this.x+(this.w*0.5),this.y+(this.h*0.76),4,9);

			ellipse(this.x+(this.w*0.7),this.y+(this.h*0.80),4,7);

			fill(115, 186, 58);

			beginShape();

			curveVertex(this.x+(this.w*0.8),this.y+(this.h*0.8));

			curveVertex(this.x,this.y+(this.h*0.8));

			curveVertex(this.x+(this.w*0.2),this.y+(this.h*0.2));

			curveVertex(this.x+(this.w*0.5),this.y+(this.h*0.1));

			curveVertex(this.x+(this.w*0.8),this.y+(this.h*0.2));

			curveVertex(this.x+this.w,this.y+(this.h*0.8));

			curveVertex(this.x+(this.w*0.8),this.y+(this.h*0.8));

			curveVertex(this.x+(this.w*0.6),this.y+(this.h*0.75));

			curveVertex(this.x+(this.w*0.3),this.y+(this.h*0.8));

			curveVertex(this.x,this.y+(this.h*0.8));

			curveVertex(this.x,this.y+(this.h*0.8));

			endShape();

			fill(237, 212, 113);

			ellipse(this.x+(this.w*0.5),this.y+(this.h*0.35),6,7);

			ellipse(this.x+(this.w*0.25),this.y+(this.h*0.5),8,9);

			ellipse(this.x+(this.w*0.75),this.y+(this.h*0.5),8,9);

			fill(0, 0, 0);

			ellipse(this.x+(this.w*0.5),this.y+(this.h*0.35),1,1);

			ellipse(this.x+(this.w*0.25),this.y+(this.h*0.5),1,1);

			ellipse(this.x+(this.w*0.75),this.y+(this.h*0.5),1,1);





			ellipse(this.x+(this.w*0.45),this.y+(this.h*0.6),1,1);

			ellipse(this.x+(this.w*0.55),this.y+(this.h*0.6),1,1);





			break;

		//if something spazzes

		default: 

			text("x_error",this.x,this.y);

			break;

	}

};





//move mnster by it's velocities respectively

Monster.prototype.move = function(){

	this.x+=this.x_veloc;

	this.y-=this.y_veloc;

};





Monster.prototype.collide=function(){

	switch(this.type){

		case 1:

			//if runs into sides, change direction

			if(this.x<5||this.x>380){

				this.x_veloc=-this.x_veloc;

				this.facing=-this.facing;

			}

			//and bounce up and down

			this.y_veloc=sin(frameCount*15);

			break;

		case 2:

			//chaeck all platforms to bounce off of

			for(var i=0;i<this.env.data.length;i++){

				//if on, bounce

				if(this.x<this.env.data[i][0]+this.env.barwidth&&this.x+this.w>this.env.data[i][0]&&this.y+this.h>this.env.data[i][1]&&this.y+this.h<this.env.data[i][1]+5&&this.y_veloc<0){

					this.y_veloc=3;

				}

			}

			//get pulled down, as long as less than terminal velocity

			if(this.y_veloc>-terminal_velocity){

				this.y_veloc-=gravity;

			}

			break;

		default:

			break;

	}

};

//the 'brain' function, is called to run monster each frame

Monster.prototype.run=function(){

	this.collide();

	this.move();

	this.display();

};

 

//main character

var Char = function(environment){

    this.x=200;

    this.y=200;

    this.width=30; // you can change this

    this.height=40; // and/or this

    this.x_veloc=0;

    this.y_veloc=8;

    this.rotate=0; //roatation of body (for trampoline)

    this.dazed=false; //do you see stars?

    this.brace=0; //the little leg twitch after a bounce

    this.facing=1; //facing left(-1) or right (1)

    this.env=environment;

    this.boost=0; //which boost powerup?

    this.boostLeft=0; //how much left

    this.def=0; //defense powerup

    this.defLeft=0; 

    

    this.bullets=[]; //array holds bullet data

    this.shotCoolDown=0; //how long until next shot

    

    

};





//draw stuff

Char.prototype.display=function(){

	

	//bullets

	for(var b=0;b<this.bullets.length;b++){

		fill(47, 255, 0);

		ellipse(this.bullets[b][0],this.bullets[b][1],6,6);

	}

	pushMatrix();

	//lots of stuff to make it look right

	translate(this.x+(this.width/2),this.y+(this.height/2));

	rotate(this.rotate);

	scale(this.facing,1);

	translate(-this.width/2,-this.height/2);

	//draw shield powerup

	if(this.def===5){

		//blink if almost done

		if(this.defLeft>100||this.defLeft%10<5&&this.defLeft>0){

			fill(84, 186, 41,80);

			stroke(160, 219, 41);

			strokeWeight(3);

			ellipse(this.width/2,this.height/2,100,100);

			strokeWeight(1);

			stroke(0, 0, 0);

		}

	}

	fill(0, 255, 0);

	//legs

	for(var l=1;l<=4;l++){

		if(this.brace===0){

			line(this.width*(l*0.21),this.height*0.9,this.width*(l*0.21),this.height*1.02);

			line(this.width*(l*0.21),this.height*1.02,this.width*(l*0.21)+(this.width*0.1),this.height*1.02);

		}else{

			line(this.width*(l*0.21),this.height*0.9,this.width*(l*0.21),this.height*0.98);

			line(this.width*(l*0.21),this.height*0.98,this.width*(l*0.21)+(this.width*0.1),this.height*0.98);

		}

	}

	fill(190, 245, 39);

	rect(0,this.height*0.3,this.width,this.height*0.6);

	strokeWeight(0.4);

	arc(this.width/2+0.5,this.height*0.35,this.width,this.height*0.7,-180,0);

	strokeWeight(1);

	fill(75, 184, 48);

	rect(0,this.height*0.68,this.width,this.height*0.1);

	rect(0,this.height*0.82,this.width,this.height*0.08);

	fill(190, 245, 39);

	strokeWeight(1.2);

	if(this.shotCoolDown>0){

		beginShape();

		curveVertex(this.width*0.6,0);

		curveVertex(this.width*0.6,0);

		curveVertex(this.width*0.7,-this.height*0.15);

		curveVertex(this.width*0.73,-this.height*0.2);

		curveVertex(this.width*0.85,-this.height*0.1);

		curveVertex(this.width*0.75,2);

		curveVertex(this.width*0.75,2);

		endShape();

		ellipse(this.width*0.8,-this.height*0.15,7,6);

		fill(0, 0, 0);

		ellipse(this.width*0.43,this.height*0.22,1,2);

		ellipse(this.width*0.58,this.height*0.22,1,2);

	}else{

		beginShape();

		curveVertex(this.width,this.height*0.4);

		curveVertex(this.width,this.height*0.4);

		curveVertex(this.width*1.15,this.height*0.42);

		curveVertex(this.width*1.45,this.height*0.4);

		curveVertex(this.width*1.45,this.height*0.55);

		curveVertex(this.width*1.15,this.height*0.53);

		curveVertex(this.width,this.height*0.55);

		curveVertex(this.width,this.height*0.55);

		endShape();

		ellipse(this.width*1.41,this.height*0.48,5,7);

		fill(0, 0, 0);

		ellipse(this.width*0.8,this.height*0.35,1,2);

		ellipse(this.width*0.67,this.height*0.35,1,2);

	}

	strokeWeight(1);

	if(this.boost===3){

		fill(202, 22, 22);

		strokeWeight(0.3);

		arc(this.width/2+1,this.height*0.2,this.width*0.9,20,-180,0);

		fill(32, 153, 46);

		arc(this.width/2,this.height*0.2,this.width/4,20,-180,0);

		strokeWeight(1);

		line(this.width/2,this.height*0.2-10,this.width/2,this.height*0.2-15);

		fill(97, 97, 97);

		pushMatrix();

		translate((this.width/2),this.height*0.2-15);

		rotate(sin(frameCount*40)*10);

		ellipse(0,0,30,4);

		ellipse(0,0,20,3);

		ellipse(0,0,10,2);

		popMatrix();

	}

	if(this.boost===4){

		

		pushMatrix();

		if(this.boostLeft<24){

			translate(0,240-(this.boostLeft*10));

			rotate(-(48-this.boostLeft*4));

		}else{

			fill(110, 120, 143);

		rect(-this.width*0.1,this.height*0.3,this.width*0.05,4);

		rect(-this.width*0.1,this.height*0.7,this.width*0.05,4);

			stroke(140, 18, 18);

			for(var l=0;l<18;l++){

				line((l*-0.6)-2,this.height,-l+2,this.height+16+(sin(l*12128)*3));

			}

			stroke(0, 0, 0);

		}

		

		

		strokeWeight(0.6);

		fill(150, 150, 150);

		arc(-7,this.height,12,this.height*1.8,-180,0);

		strokeWeight(0.2);

		fill(219, 194, 35);

		arc(-7,this.height*0.3,8,this.height*0.4,-180,0);

		strokeWeight(1);

		line(-2,this.height,-13,this.height);

		line(-4,this.height-3,-10,this.height-3);

		line(-4,this.height-5,-10,this.height-5);

		popMatrix();

	}

	//draw stars

	if(this.dazed){

		noFill();

		image(star,this.width/2-7+(sin(frameCount*10)*16),-7+cos(frameCount*10+10)*6,15,15);

		image(star,this.width/2-7+(sin(frameCount*10+100)*16),-7+cos(frameCount*10+100)*6,15,15);

		image(star,this.width/2-7+(sin(frameCount*10+200)*16),-7+cos(frameCount*10+200)*6,15,15);

	}

	

	popMatrix();

	

};

Char.prototype.move=function(){

	this.x+=this.x_veloc;

	this.y-=this.y_veloc;

	//teleport to other side if goes to far

	if(this.x>400){

		this.x=-20;

	}

	if(this.x<-20){

		this.x=400;

	}

	//bullets move by velocity

	for(var b=0;b<this.bullets.length;b++){

		this.bullets[b][0]+=this.bullets[b][2];

		this.bullets[b][1]-=this.bullets[b][3];

	}

	//if powerups

	if(this.boost===3){

		this.y_veloc=10;

	}

	if(this.boost===4){

		this.y_veloc=15;

	}

	if(this.boostLeft>0){

		this.boostLeft--;

	}else{

		this.boost=0;

	}

	

	if(this.defLeft>0){

		this.defLeft--;

	}else{

		this.def=0;

	}

	

};





Char.prototype.shoot=function(){

	var yv;

	if(this.y_veloc>0){

		yv=this.y_veloc+8;

	}else{

		yv=10;

	}

	this.bullets.push([this.x+(this.width/2)+this.facing*6,this.y-5,this.facing*3,yv]);

};





Char.prototype.collide=function(){

	//check for platforms

	for(var i=0;i<this.env.data.length;i++){

		if(this.x<this.env.data[i][0]+this.env.barwidth&&this.x+this.width>this.env.data[i][0]&&this.y+this.height>this.env.data[i][1]&&this.y+this.height<this.env.data[i][1]+7&&this.y_veloc<0&&!this.dazed){

			switch(this.env.data[i][2]){

				//brown breaking platform

				case 3:

					if(this.env.data[i][3]===0){

						//increase bounced on variable

						this.env.data[i][3]++;

					}

					break;

				//all other platforms

				default:

					//bounce

					this.y_veloc=8;

					this.env.data[i][3]++;

					this.brace=15;

					break;

			}

		}

	}

	//check for monsters

	for(var i=0;i<this.env.ent.length;i++){

		//jump on its head...

		if(this.x<this.env.ent[i].x+this.env.ent[i].w&&this.x+this.width>this.env.ent[i].x&&this.y+this.height>this.env.ent[i].y-2&&this.y+this.height<this.env.ent[i].y+5&&this.y_veloc<0&&!this.dazed&&this.boost===0){

			this.env.ent.splice(i,1);

			this.y_veloc=10;

		//...else you're dead

		}else if(this.x<this.env.ent[i].x+this.env.ent[i].w&&this.x+this.width>this.env.ent[i].x&&this.y+this.height>this.env.ent[i].y&&this.y<this.env.ent[i].y+this.env.ent[i].h&&this.def===0&&this.boost===0){

			this.dazed=true;

		}

	}

	//powerups that you jump on

	for(var p=0;p<this.env.pow.length;p++){

		if(this.x<this.env.pow[p].x+this.env.pow[p].width&&this.x+this.width>this.env.pow[p].x&&this.y+this.height>this.env.pow[p].y-2&&this.y+this.height<this.env.pow[p].y+3&&this.y_veloc<0&&!this.dazed&&this.env.pow[p].used===0){

			switch(this.env.pow[p].type){

				//spring

				case 1:

					this.y_veloc=12;

					this.env.pow[p].used++;

					break;

				//trampoline

				case 2:

					this.y_veloc=15;

					this.rotate=360;

					this.env.pow[p].used++;

					break;    

				default:

					break;

			}

		}

		//powerups you touch

		if(this.x<this.env.pow[p].x+this.env.pow[p].width&&this.x+this.width>this.env.pow[p].x&&this.y+this.height>this.env.pow[p].y&&this.y<this.env.pow[p].y+this.env.pow[p].height&&!this.dazed&&this.env.pow[p].used===0){

			switch(this.env.pow[p].type){

				//twirly beanie

				case 3:

					if(this.boost===0){

						this.boost=3;

						this.boostLeft=300;

						this.env.pow[p].used++;

					}

					break;

				//jetpack

				case 4:

					if(this.boost===0){

						this.boost=4;

						this.boostLeft=220;

						this.env.pow[p].used++;

					}

					break;

				//shield

				case 5:

					if(this.def===0){

						this.def=5;

						this.defLeft=800;

						this.env.pow[p].used++;

					}

					break;

				default:

					break;

			}

		}

	}

	//fall

	if(this.y_veloc>-terminal_velocity){

		this.y_veloc-=gravity;

	}

	//decelerate sideways

	if(this.x_veloc!==0){

		this.x_veloc=floor((abs(this.x_veloc)-abs(this.x_veloc)/8)*10)/10*(this.x_veloc/abs(this.x_veloc));

	}

	//stop the leg bracing

	if(this.brace>0){

		this.brace--;

	}

	//get rightside up dude

	if(this.rotate>0){

		this.rotate-=8;

	}

	//spawn bars as you get higher

	if(this.y<150-this.env.getOffset()&&this.y_veloc>0){

		this.env.addOffset(this.y_veloc);

		if(round(random(0, this.y-this.env.data[this.env.data.length-1][1]/120))===0){

			this.env.addBar();

		} if(this.y<this.env.data[this.env.data.length-2][1]){

			this.env.addBar();

		}else if(round(random(0,40))===20){

			this.env.addBar();

		}

	}

	

	

	//bullets

	for(var b=0;b<this.bullets.length;b++){

		//search all monsters

		for(var i=0;i<this.env.ent.length;i++){

			//if touching monster

			if(this.bullets[b][0]<this.env.ent[i].x+this.env.ent[i].w+5&&this.bullets[b][0]>this.env.ent[i].x-5&&this.bullets[b][1]>this.env.ent[i].y-5&&this.bullets[b][1]<this.env.ent[i].y+5){

				//kill it

				this.env.ent.splice(i,1);

			}

		}

	}

};

Char.prototype.control=function(){

	if(keyDown[RIGHT]){

		if(this.x_veloc<5){

			this.x_veloc+=1.5;

			this.facing=1;

		}

	}

	if(keyDown[LEFT]){

		if(this.x_veloc>-5){

			this.x_veloc-=1.5;

			this.facing=-1;

		}

	}

	//shoot if cooldown is up

	if(keyDown[UP]&&this.shotCoolDown===0){

		this.shoot();

		this.shotCoolDown=4;

	}else if(!keyDown[UP]&&this.shotCoolDown>0){

		this.shotCoolDown--;

	}

	

};

//brain function(like draw() kind of)

Char.prototype.run=function(){

	this.collide();

	this.move();

	this.control();

	this.display();

};









var Powerup = function(x,y){

	//random type

	this.type=ceil(random(0,5));

	//set up based on type

	switch(this.type){

		//spring

		 case 1:

			this.width=10;

			this.height=10;

			this.x=x+round(random(0,15));

			break;

		//trampoline

		case 2:

			this.width=30;

			this.height=15;   

			this.x=x+5;

			break;

		//propeller beanie

		case 3:

			this.width=25;

			this.height=25;   

			this.x=x+5;

			break;

		//jetpack

		case 4:

			this.width=20;

			this.height=30;   

			this.x=x+round(random(0,17));

			break;

		//shield

		case 5:

			this.width=25;

			this.height=25;   

			this.x=x+3;

			break;

		default:

			break;

	}

	this.y=y-this.height;

	this.used=0;

};





Powerup.prototype.display=function(){

	switch(this.type){

		case 1:

			noFill();

			stroke(97, 97, 97);

			pushMatrix();

			translate(this.x,this.y);

			beginShape();

			var space=(this.used+1)*2;

			for(var c=0;c<4;c++){

				curveVertex(0,this.height-(c*space));

				curveVertex(this.width/2,this.height-(c*space)-space*0.8);

				curveVertex(this.width,this.height-(c*space)-space*0.5);

				curveVertex(this.width/2,this.height-(c*space)+space/6);

			}

				

			endShape();

			stroke(0, 0, 0);

			popMatrix();

			

			break;

		case 2:

			line(this.x+(this.width/2),this.y+(this.height/2),this.x+(this.width/2),this.y+this.height);

			line(this.x+(this.width/2)-5,this.y+(this.height/2),this.x+2,this.y+this.height);

			line(this.x+(this.width/2)+5,this.y+(this.height/2),this.x+this.width-2,this.y+this.height);

			fill(150, 150, 150);

			ellipse(this.x+(this.width/2),this.y+(this.height/2),this.width*0.8,this.height*0.5);

			fill(255, 0, 0);

			ellipse(this.x+(this.width/2),this.y+(this.height/2)-1,this.width*0.6,this.height*0.4);

			fill(247, 255, 0);

			ellipse(this.x+(this.width/2),this.y+(this.height/2)-2+this.used,this.width*0.4,this.height*0.2);

			

			break;

		case 3:

			if(this.used===0){

				strokeWeight(0.5);

				fill(209, 27, 27);

				arc(this.x+(this.width/2),this.y+this.height,this.width,this.height,-180,0);

				fill(62, 179, 62);

				arc(this.x+(this.width/2),this.y+this.height,this.width/3,this.height,-180,0);

				strokeWeight(1);

				fill(219, 184, 28);

				ellipse(this.x+(this.width/2)-5,this.y+(this.height/2)-4,12,3);

				ellipse(this.x+(this.width/2)+5,this.y+(this.height/2)-4,12,3);

				line(this.x,this.y+this.height,this.x+this.width-1,this.y+this.height);

				line(this.x+(this.width/2)-1,this.y+(this.height/2),this.x+(this.width/2)-1,this.y+(this.height/2)-6);









			}

			break;   

		case 4:

			if(this.used===0){

				fill(104, 87, 140);

				rect(this.x+this.width*0.4,this.y+this.height*0.3,this.width/2,5);

				rect(this.x+this.width*0.4,this.y+this.height*0.7,this.width/2,5);

				strokeWeight(0.5);

				fill(148, 148, 148);

				arc(this.x+(this.width*0.2),this.y+this.height,this.width/2,this.height*2,-180,0);

				arc(this.x+(this.width*0.8),this.y+this.height,this.width/2,this.height*2,-180,0);

				strokeWeight(0.1);

				fill(224, 210, 61);

				arc(this.x+(this.width*0.2),this.y+this.height/5,this.width/3,this.height*0.4,-180,0);

				arc(this.x+(this.width*0.8),this.y+this.height/5,this.width/3,this.height*0.4,-180,0);

				strokeWeight(1);

				line(this.x-1,this.y+this.height,this.x+this.width,this.y+this.height);

				line(this.x+1,this.y+(this.height*0.9),this.x+this.width/4,this.y+(this.height*0.9));

				line(this.x+this.width*0.7,this.y+(this.height*0.9),this.x+this.width-2,this.y+(this.height*0.9));

				line(this.x+1,this.y+(this.height*0.8),this.x+this.width/4,this.y+(this.height*0.8));

				line(this.x+this.width*0.7,this.y+(this.height*0.8),this.x+this.width-2,this.y+(this.height*0.8));

			}

			break;

		case 5:

			if(this.used===0){

				noStroke();

				fill(214, 153, 11,80);

				ellipse(this.x+(this.width/2),this.y+(this.height/2),this.width,this.height);

				stroke(0, 0, 0);

				fill(53, 150, 48);

				beginShape();

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.4),this.y+(this.height*0.3));

				curveVertex(this.x+(this.width*0.2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.2),this.y+(this.height*0.6));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				endShape();

				fill(48, 74, 148);

				beginShape();

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.6),this.y+(this.height*0.3));

				curveVertex(this.x+(this.width*0.8),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.8),this.y+(this.height*0.2));

				curveVertex(this.x+(this.width*0.8),this.y+(this.height*0.6));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				curveVertex(this.x+(this.width/2),this.y+(this.height*0.8));

				endShape();

			}

			break;

		default:

			break;

	}

};

Powerup.prototype.run=function(){

	this.display();

};

 

var Level = function(){

    this.data=[[]]; //holds platform data

    this.ent=[]; //holds monsters

    this.pow=[]; //holds powerups

    this.barwidth=40;

    this.offset=0;

};

    

//set up some bars for the beginning

Level.prototype.setup=function(){

	this.data.push([random(5,370),random(300,400),1,0,0,0]);

	this.data.push([random(5,370),random(100,200),1,0,0,0]);

	this.data.push([random(5,370),random(100,300),1,0,0,0]);

	this.data.push([random(5,370),random(0,50),1,0,0,0]);

	this.data.push([random(5,370),random(0,-50),1,0,0,0]);

	this.data.push([random(5,370),random(-40,-200),1,0,0,0]);

	this.data.push([random(5,370),random(0,300),1,0,0,0]);

};

//add a new platform

Level.prototype.addBar=function(){

	var type;

	var x_veloc;

	var y_veloc;

	switch(round(random(1,12))){

		//sideways moving blue

		case 1:

			type=2;

			x_veloc=2;

			y_veloc=0;

			break;

		//brown breaking one

		case 2:

			type=3;

			x_veloc=0;

			y_veloc=0;

			//add real bar to make it possible to get up

			this.addBar();

			break;

		//up and down gray

		case 3:

			type=4;

			x_veloc=0;

			y_veloc=2;

			break;

		//basic green

		default:

			type=1;

			x_veloc=0;

			y_veloc=0;

			break;

		

	}

	var x=random(5,370);

	var y=random(-10,-50)-this.offset;

	//finally add the bar

	this.data.push([x,y,type,0,x_veloc,y_veloc]);

	if(type===1){

		//maybe spawn a monster

		if(round(random(0,10))===1){

			switch(round(random(1,2))){

				case 1:    

					this.ent.push(new Monster(random(5,370),random(-20,-60)-this.offset,1,this));

					break;

				case 2:    

					this.ent.push(new Monster(x-5,y-55,2,this));

					break;

				default:

					break;

			}

		//or make a powerup

		}else if(round(random(0,10))===1){

		   this.pow.push(new Powerup(x,y));

		}

		

	}

};

//return the current offset

Level.prototype.getOffset=function(){

	return this.offset;

};

//add value to the offset

Level.prototype.addOffset=function(value){

	this.offset+=value;

	if(value>0){

		gameScore+=value;

	}

};





Level.prototype.move=function(){

	//iterate through all bars 

	for(var i=0;i<this.data.length;i++){

		switch(this.data[i][2]){

			//make blue bar bounce off sides

			case 2:

				if(this.data[i][0]<5){

					this.data[i][4]=-this.data[i][4];

				}else if(this.data[i][0]>370){

					this.data[i][4]=-this.data[i][4];

				}

				break;

			//brown falls if broken

			case 3:

				if(this.data[i][3]!==0){

					if(this.data[i][5]<terminal_velocity){

						this.data[i][5]+=1;

					}

					

				}

				break;

			//move gray up and down

			case 4:

				//this.data[i][5]=ceil(cos(this.data[i][0]+frameCount*2)+1)*4-5;

				if(floor(this.data[i][0]+frameCount)%100===0){

				    this.data[i][5]=-this.data[i][5];

				}

				break;

			default: 

				break;

		}

		//move x and y by their respective velocities

		this.data[i][0]+=this.data[i][4];

		this.data[i][1]+=this.data[i][5];

		

		//if it get below the screen, delete it

		if(this.data[i][2]===4){

		   if(this.data[i][1]>540-this.offset){

				this.data.splice(i,1);

			} 

		}else{

			if(this.data[i][1]>400-this.offset){

				this.data.splice(i,1);

			}

		}

		

	} 

	

};





Level.prototype.display=function(){

	//iterate through each bar

	for(var i=0;i<this.data.length;i++){

		//create easier to read variables

		var x = this.data[i][0];

		var y = this.data[i][1];

		var type = this.data[i][2];

		var useNum = this.data[i][3];

		switch(type){

			case 1:

				fill(51, 242, 3);

				rect(x,y,this.barwidth,8,5);

				fill(189, 230, 187);

				noStroke();

				rect(x+3,y+4,4,3,3);

				rect(x+this.barwidth-5,y+3,4,3,3);

				stroke(0, 0, 0);

				break;

			case 2:

				fill(5, 177, 240);

				rect(x,y,this.barwidth,8,5);

				fill(149, 194, 214);

				noStroke();

				rect(x+3,y+4,4,3,3);

				rect(x+this.barwidth-5,y+3,4,3,3);

				stroke(0, 0, 0);

				break;

			case 3:

				

				fill(163, 110, 63);

				pushMatrix();

				translate(x,y);

				strokeWeight(0.8);

				if(useNum!==0){

					rotate(5);

				}

				beginShape();

				curveVertex(this.barwidth/2-2,0);

				curveVertex(this.barwidth/2-2,0);

				curveVertex(3,1);

				curveVertex(3,8);

				curveVertex(this.barwidth/2-4,8);

				curveVertex(this.barwidth/2-4,8);

				curveVertex(this.barwidth/2-4,4);

				curveVertex(this.barwidth/2-4,4);

				curveVertex(this.barwidth/2-2,0);

				curveVertex(this.barwidth/2-2,0);

				endShape();

				if(useNum!==0){

					rotate(-10);

				}

				beginShape();

				curveVertex(this.barwidth/2+2,0);

				curveVertex(this.barwidth/2+2,0);

				curveVertex(this.barwidth-3,1);

				curveVertex(this.barwidth-3,8);

				curveVertex(this.barwidth/2+3,8);

				curveVertex(this.barwidth/2+3,8);

				curveVertex(this.barwidth/2,4);

				curveVertex(this.barwidth/2,4);

				curveVertex(this.barwidth/2+2,0);

				curveVertex(this.barwidth/2+2,0);

				endShape();

				

				strokeWeight(1);

				fill(186, 143, 106);

				noStroke();

				rect(3,4,4,3,3);

				rect(this.barwidth-5,3,4,3,3);

				stroke(0, 0, 0);

				popMatrix();

				break;

			case 4:

				fill(110, 110, 110);

				rect(x,y,this.barwidth,8,5);

				fill(148, 148, 148);

				noStroke();

				rect(x+3,y+4,4,3,3);

				rect(x+this.barwidth-5,y+3,4,3,3);

				stroke(0, 0, 0);

				break;

			default: 

				fill(0, 0, 0);

				rect(x,y,this.barwidth,5);

				break;

		}

	}

};





Level.prototype.run=function(){

	this.display();

	this.move();

	//if powerups are below screen, delete 'em

	for(var p=0;p<this.pow.length;p++){

		this.pow[p].run();

		if(this.pow[p].y>400-this.offset){

			this.pow.splice(p,1);

		}

	}

	//if monster below screen, delete

	for(var i=0;i<this.ent.length;i++){

		this.ent[i].run();

		

		if(this.ent[i].y>400-this.offset){

			this.ent.splice(i,1);

		}

	}

};

 

//make new level

var gameLevel= new Level();

//set that level up

gameLevel.setup();

//create a player inside that level

var player= new Char(gameLevel);

 

var draw= function() {

    background(255, 255, 255);

    stroke(221, 222, 189);

    //draw graph paper

    for(var g=1;g<=25;g++){

        line(0,g*16,400,g*16);

        line(g*16,0,g*16,400);

    }

    stroke(235, 176, 176);

    line(32,0,32,400);

    stroke(0, 0, 0);

    //run the level stuffs, graphics offset by player height

    pushMatrix();

    translate(0,gameLevel.getOffset());

    gameLevel.run();

    player.run();

    popMatrix();

    //display score

    fill(0, 0, 0,40);

    rect(-1,-1,402,25);

    fill(0, 0, 0);

    textSize(20);

    text(round(gameScore),40,19);

    

    //restart level

    if(keyDown[ENTER]){

        gameLevel=new Level();

        gameLevel.setup();

        player=new Char(gameLevel);

        gameScore=0;

    }

    

};

 

var keyPressed=function(){

    keyDown[keyCode]=true;

};

var keyReleased=function(){

    keyDown[keyCode]=false;

};
