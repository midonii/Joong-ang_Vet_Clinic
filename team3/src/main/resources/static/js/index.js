

$(function(){
	
$.post({
	url: "/ReCount",
	dataType: "json"
}).done(function(data) {
	if (data.reservCount != null && data.recepCount != null && data.diagCount !=null) {
		var reservCount = data.reservCount;
		var recepCount = data.recepCount;
		var diagCount = data.diagCount;
		$("#reservCount").append(reservCount);
		$("#recepCount").append(recepCount);
		$("#diagCount").append(diagCount);
	}
}).fail(function() {
	alert("문제발생");
});
});



