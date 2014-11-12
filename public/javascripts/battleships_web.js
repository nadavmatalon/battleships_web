function togglestyle(element) {
	if(element.className === "coord") {
		element.className = "selected";
		coords.value += element.value + ', ';
	} else {
		element.className="coord";
		var new_coords = coords.value.split(', ');
		remove(new_coords, element.value);
		coords.value = new_coords.join(', ');
	}
}

function remove(array, item) {
	for(var i = array.length; i--;) {
		if(array[i] === item) {
			array.splice(i, 1);
		}
	}
}
