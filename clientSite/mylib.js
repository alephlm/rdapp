function supports_html5_storage() {
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
  } catch (e) {
    return false;
  }
}

var path = window.location.pathname.split('/');
var page = path[path.length-1];

if(!localStorage["url"]){
	localStorage["url"] = "";
}

var justAddedPage = false;

if(localStorage["url"].indexOf(page) == -1){
	localStorage["url"] +=  page + ',';
	justAddedPage = true;

}

if(justAddedPage && localStorage["email"]){
	sendInfo();
}

function clearLocalStorage(){
	localStorage.removeItem("email");
	localStorage.removeItem("url");
	localStorage.removeItem("action");
}

function sendInfo(form, event){
	if(event) event.preventDefault();
	if(!localStorage["email"]){
		localStorage["email"] = form.elements.email.value;
	}
	if(!localStorage["action"]){
		localStorage["action"] = form.action;
	}
	var urls = localStorage["url"].slice(0,-1).split(',');
	var pages = [];
	if(form) form.elements = [];

	urls.map(function(url, i){
		pages.push({url: url});
	});

	fetch(localStorage["action"],
	{
	   method: "POST",headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
	    body: JSON.stringify({contato: {email: localStorage["email"]}, pages: pages})
	})
	.then(function(res){ return res.json(); })
	.then(function(data){ if(form){
		alert("Cadastro realizado.");	
		location.reload(true); 
		}	 
	});
}
