function cldar(board_no, date) {
    
    id = board_no;
    
    if( typeof( date ) !== 'undefined' ) {
		date = date.split('-');
		date[1] = date[1] - 1;
		date = new Date(date[0], date[1], date[2]);
	} else {
		var date = new Date();
	}
	var currentYear = date.getFullYear();
	//년도를 구함
	
	var currentMonth = date.getMonth() + 1;
	//연을 구함. 월은 0부터 시작하므로 +1, 12월은 11을 출력
	
	var currentDate = date.getDate();
	//오늘 일자.
	
	date.setDate(1);
	var currentDay = date.getDay();
	//이번달 1일의 요일은 출력. 0은 일요일 6은 토요일
	
	var dateString = new Array('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
	var lastDate = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if( (currentYear % 4 === 0 && currentYear % 100 !== 0) || currentYear % 400 === 0 )
		lastDate[1] = 29;
	//각 달의 마지막 일을 계산, 윤년의 경우 년도가 4의 배수이고 100의 배수가 아닐 때 혹은 400의 배수일 때 2월달이 29일 임.
	
	var currentLastDate = lastDate[currentMonth-1];
	var week = Math.ceil( ( currentDay + currentLastDate ) / 7 );
	//총 몇 주인지 구함.
	
	if(currentMonth != 1)
		var prevDate = currentYear + '-' + ( currentMonth - 1 ) + '-' + currentDate;
	else
		var prevDate = ( currentYear - 1 ) + '-' + 12 + '-' + currentDate;
	//만약 이번달이 1월이라면 1년 전 12월로 출력.
	
	if(currentMonth != 12) 
		var nextDate = currentYear + '-' + ( currentMonth + 1 ) + '-' + currentDate;
	else
		var nextDate = ( currentYear + 1 ) + '-' + 1 + '-' + currentDate;
	//만약 이번달이 12월이라면 1년 후 1월로 출력.

	
	if( currentMonth < 10 )
		var currentMonth = '0' + currentMonth;
	//10월 이하라면 앞에 0을 붙여준다.
    
	var calendar = '';
    
    calendar += '<div class="title thm-border">';
    calendar +=     '<div class="thm-color">';
    calendar +=         '<input type="text" class="board-title ' + board_no + 'title">';
    calendar +=     '</div>';
    calendar +=     '<div class="cldar-today">';
    calendar +=         currentYear + '年 ' + currentMonth + '月';
    calendar +=     '</div>';
    calendar +=     '<div class="cldar-btns">';
    calendar +=         '<a class="cldar-back" onclick="cldar(\'' + board_no + '\', \'' + prevDate + '\')"></a>';
    calendar +=         '<a class="cldar-next" onclick="cldar(\'' + board_no + '\', \'' + nextDate + '\')"></a>';
    calendar +=     '</div>';
    calendar += '</div>';
    calendar += '<div class="content-2-1">';
    calendar +=     '<div class="board-cldar">';
    calendar +=         '<table border=0>';
    calendar +=             '<tr>';
    calendar +=                 '<th><a class="sun">日</a></th>';
    calendar +=                 '<th>月</th>';
    calendar +=                 '<th>火</th>';
    calendar +=                 '<th>水</th>';
    calendar +=                 '<th>木</th>';
    calendar +=                 '<th>金</th>';
    calendar +=                 '<th><a class="sat">土</a></th>';
    calendar +=             '</tr>';
    
	var dateNum = 1 - currentDay;
	
	week = 5;
	
	for(var i = 0; i < week; i++) {
		calendar +=         '<tr>';
		for(var j = 0; j < 7; j++, dateNum++) {
			if( dateNum < 1 || dateNum > currentLastDate ) {
				calendar += '				<td class="' + dateString[j] + '"> </td>';
				continue;
			}
			calendar += '				<td id="btnToday" class="' + dateString[j] + '">' + dateNum + '</td>';
		}
		calendar +=         '</tr>';
	}
	
	calendar +=        '</table>';
    calendar +=     '</div>';
    calendar += '</div>';
    var temp = $('.boardlist .' + board_no + ' .' + board_no + 'title').val();
    $('.boardlist li.thm-board.' + board_no).html(calendar);
    $('.boardlist .' + board_no + ' .' + board_no + 'title').val(temp);
}