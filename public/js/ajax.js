var options={ 
	target: '#result',
	success: function(){
		return false; 
	},
	error: function(xhr){
		$('#result').html(xhr.responseText);
	}
};

$('#yanc').ajaxForm(options);

