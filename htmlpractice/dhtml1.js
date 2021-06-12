function numericonly()
{
	if(!(event.keyCode >= 47 && event.keyCode <= 57))
		event.returnValue=false;
}

function countwords()
{
	var message = document.getElementById('txtMessage').value;
	message = message.replace(/\s+/g, ' ');
	var numberofWords = message.split(' ').length;
	
	document.getElementById('txtTrack').value = 
		'words Remaining: ' + eval(50 - numberofWords);
	if(numberofWords > 50)
		alert('Too many words.');	
}