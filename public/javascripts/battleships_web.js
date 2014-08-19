function togglestyle(element) {
	if(element.className == "coord") {
		element.className="selected";
		coords.value+=element.value+', ';
		// console.log(coords.value);
		// console.log(element.className);
	} else {
		element.className="coord";
		var new_coords = coords.value.split(', ');
		remove(new_coords, element.value);
		coords.value = new_coords.join(', ');
		// console.log(coords.value);
		// console.log(element.className);
	}
}
function remove(array, item) {
		for(var i = array.length; i--;) {
  		if(array[i] === item) {
      		array.splice(i, 1);
  		}
	}
}
