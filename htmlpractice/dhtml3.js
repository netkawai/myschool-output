function displayImage(url)
{
	document.getElementById('imgPhoto').style.visibility='visible';
	document.getElementById('imgPhoto').style.src = url;
}

function hideImage()
{
	document.getElementById('imgPhoto').style.visibility = 'hidden';
}