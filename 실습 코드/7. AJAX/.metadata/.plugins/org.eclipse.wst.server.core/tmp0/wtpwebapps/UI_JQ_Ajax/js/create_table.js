function makeTable(elem){
	var $table = $("<table border=1>");
	
	//변수 선언은 위처럼 할 수 있고
	//지금처럼도 할 수 있음.
	for(var i=0; i<1; i++){
		$tr = $("<tr>");	
		for(var j=0;j<elem.eq(0).children().length;j++){
			$td = $("<td>").append( elem.eq(0).children().eq(j).prop("tagName"));
			$tr.append($td);
		}
		$table.append($tr);
	}
	//위에까지 컬럼 제목 달았음.
	
	for(var i=0;i<elem.length;i++){
		$tr = $("<tr>");
		for(var j=0;j<elem.eq(i).children().length;j++){
			$td = $("<td>").append( elem.eq(i).children().eq(j).text() );
			$tr.append($td);
		}
		$table.append($tr);
	}
	
	return $table;
	
	
	
}