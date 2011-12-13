onload=function () {
	var source = document.getElementsByName('source');
	for (i=0; i < source.length; i++) {
		pie = source[i];
		if (pie.checked) {
			showDiv(pie.value);
		};
	};

	var method = document.getElementsByName('method');
	for (i=0; i < method.length; i++) {
		pie = method[i];
		if (pie.checked) {
			showDiv(pie.value);
		};
	};

	var calc_for = document.getElementById('calc_for1');
	if (calc_for.selectedIndex) {
		pie = calc_for.selectedIndex;
		showDiv(calc_for.options[pie].value);
	};

	var premix_calc_for = document.getElementById('premix_calc_for');
	if (premix_calc_for.selectedIndex) {
		pie = premix_calc_for.selectedIndex;
		showDiv(premix_calc_for.options[pie].value);
	};

};

function showDiv(method) {
	document.getElementById('dump').style.display = "none"; 
	document.getElementById('premix_dump').style.display = "none";
	document.getElementById('target').style.display = "none";
	document.getElementById('premix_target').style.display = "none";
	if (method && document.getElementById(method)) {
		document.getElementById(method).style.display = "block";
	}
	if (method && document.getElementsByName(method)) {
		document.getElementsByName(method).checked = true;
	}
};

