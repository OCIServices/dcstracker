// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function resizetabs(){
	var tabheight = 0;
	var containers = document.getElementsByClassName("Container");
	for(var i=0;i<containers.length;i++){
		var tabs = containers[i].getElementsByTagName("li");
		for(var k=0;k<tabs.length;k++){
			var label = tabs[k].getElementsByTagName("label")[0];
			var content = tabs[k].getElementsByTagName("div");
			if(content){
				for(var x=0;x<content.length;x++){
					if(content[x].className == "tab-content animated fadeIn"){
						if(content[x].clientHeight > content[x].style.height){
							var height = content[x].clientHeight+label.clientHeight+5;
						}else{
							var height = content[x].style.height+label.clientHeight+5;
						}
						//content[x].style.height = content[x].clientHeight+50+"px";
					}
				}
				if(height > tabheight){
					var tabheight = height;
				}
			}
		}
		containers[i].style.height = tabheight+"px";
	}
	
	var top = 0;
	var ul = document.getElementsByClassName("tabs");
	for(var i=0;i<ul.length;i++){
		var width = 0;
		var li = ul[i].children;
		for(var x=0;x<li.length;x++){
			var width = width + li[x].clientWidth;
		}
		var lines = Math.floor(width/ul[i].clientWidth) + 1;
		if(lines > 1){
			for(var x=0;x<li.length;x++){
				var tabcontent = li[x].lastElementChild;
				if(tabcontent.className == "tab-content animated fadeIn"){
					tabcontent.style.top = lines * 35+"px";
				}
			}
		}
	}
		
}

function clickhandler(e, url){
	if(e.button == 0){
		window.location.assign(url);
	}else if(e.button == 1){
		window.open(url);
	}
}

function popup(e, url){
	window.open(url, '_blank', 'height=700,width=900,toolbar=0,location=0,menubar=0,scrollbars=1,status=0,titlebar=0');
}

function redirect(e, url){
	window.opener.location.assign(url);
	window.close();
}

function selecttable(sel) {
	window.location.assign("index.php?page=advanced&table0="+sel.value);
}

function selectcol(sel) {
	var table = document.getElementsByName("table0")[0].value;
	window.location.assign("index.php?page=advanced&table0="+table+"&col0="+sel.value);
}

document.addEventListener('touchstart', handleTouchStart, false);        
document.addEventListener('touchmove', handleTouchMove, false);

var xDown = null;                                                        
var yDown = null;                                                        

function handleTouchStart(evt) {                                         
    xDown = evt.touches[0].clientX;                                      
    yDown = evt.touches[0].clientY;                                      
};                                                

function handleTouchMove(evt) {
    if ( ! xDown || ! yDown ) {
        return;
    }

    var xUp = evt.touches[0].clientX;                                    
    var yUp = evt.touches[0].clientY;

    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if ( Math.abs( xDiff ) > Math.abs( yDiff ) ) {/*most significant*/
        if ( xDiff > 0 ) {
            document.getElementById("AppLeftBar").style.display = "none";
            document.getElementById("blackout").style.display = "none";
        } else {
            document.getElementById("AppLeftBar").style.display = "block";
            document.getElementById("blackout").style.display = "block";
        }                       
    } else {
        if ( yDiff > 0 ) {
            /* up swipe */ 
        } else { 
            /* down swipe */
        }                                                                 
    }
    /* reset values */
    xDown = null;
    yDown = null;                                             
};
