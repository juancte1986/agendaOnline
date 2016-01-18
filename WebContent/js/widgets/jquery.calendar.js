	$.widget('custom.applyCalendar', {
	options : {
		urlContext : "",
	},

	_create : function() {
		this._bindVars();
		this._initialize();
		this._bindEvents();
	},

	_bindVars : function() {
		this.contextUrl = this.options.urlContext;
		this.table = this.element.find("#table");
		this.week = new Array();
		this.events = new Array();
		this.drag = new Object();
		this.dragPosition = {};
		this.today="";
	},

	_initialize : function() {
		this._loadEventsCallback(this._getCurrentDate());
		this._createGrid();
	},
	
	_createGrid : function() {
		var i;
		var top;
		for( i = 0, top = 0; i < 50; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnSunday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnMonday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnTuesday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px",
			});
			$($line).appendTo(this.element.find(".columnWednesday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnThursday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnFriday"));
		}
		for( i = 0, top = 0; i < 47; i++, top+=20){
			$line = $('<div class="celda"></div>');
			$line.css({
				top: top+"px"
			});
			$($line).appendTo(this.element.find(".columnSaturday"));
		}
	},
	
	_createEventDrag : function(clazz, column) {
		$(clazz).draggable({
			grid: [200,20],
			containment : column,
			start : $.proxy(this._setDrag, this),
			stop : $.proxy(this._updateEventCallback, this)
		});
	},
	
	_applyToolTips : function(clazz) {
		$(clazz).tooltipster({
			interactive: true, // crea un toolstip interactivon
			functionBefore: $.proxy(this._loadContentTooltip, this),
			position: "top-left"
		});
	},
	
	_loadContentTooltip : function (origin, continueTooltip) {
		name = origin.find(".name").val();
		startTime = origin.find(".startTime").val();
		endTime = origin.find(".endTime").val();
		id= origin.find(".id").val();
		type = origin.find(".type").val();
		var url; 
		if(type == "meeting"){
			
			url = "/agendaOnline/detailMeeting.htm?id=" +  id;
		}
		if(type == "privateEvent"){
			url = "/agendaOnline/detailPrivateEvent.htm?id=" +  id;
		}
		origin.tooltipster('content', $('<a class="linkCalendar" href="' + url + '">' + name + ' ' + startTime +' - ' + endTime + ' <i class="glyphicon glyphicon-time"></i></a> '));
		continueTooltip();
	},
	
	_setDrag : function(event, ui) {
		this.drag = $(ui.helper[0]);
		this.drag.tooltipster('disable');
		this.dragPosition.top =  ui.position.top;
		this.dragPosition.left = ui.position.left;
	},
	
	_updateEventCallback : function(event, ui) {
		var url = this.contextUrl + "/services/updateTimeEvent/" + this.drag.find(".id").val() ;
		meeting={};
		meeting.id = this.drag.find(".id").val();
		var position = this._getPosition(this.drag);
		meeting.top = position.top;
		meeting.height = position.height;
		meeting.flat = position.flat;
		$.ajax({
			url : url,
			type: "POST",
			data: JSON.stringify(meeting),
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			success : $.proxy(this._processEvents, this),
			error :  $.proxy(this._processError, this),
		});
	},
	
	_processError: function() {
		this.drag.css({
			top: this.dragPosition.top +"px",
			left: this.dragPosition.left +"px"
		});
		this.drag.tooltipster('enable');
		alert("Error al modidicar la hora del evento ");
	},
	_processEvents : function(data) {
		if(!data.error){
			var clazz = this._getClass(this.drag.attr('class').split(" "));
			this._ordenarCeldaActual(this.drag, clazz);
			this._ordenarCeldas($("div." + clazz));
			this.drag.find(".startTime").val(data.startTime);
			this.drag.find(".endTime").val(data.endTime);
			this.drag.tooltipster('enable');
			alert("El horario se modifico correctamente");
		} else {
			alert(data.message);
			this.drag.css({
				top: this.dragPosition.top +"px",
				left: this.dragPosition.left +"px"
			});
			this.drag.tooltipster('enable');
		}
	},
	
	_getClass : function(clazz) {
		var dragClass  ="";
		for(var i = 0; i < clazz.length; i++){
			if(clazz[i] == "eventsSunday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsMonday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsTuesday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsWednesday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsThursday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsFriday"){
				dragClass = clazz[i];
			}
			if(clazz[i] == "eventsSaturday"){
				dragClass = clazz[i];
			}
		}
		return dragClass;
	},
	
	_bindEvents : function() {
		this.element.find("#btn-next").click($.proxy(this._loadNextCalendar,this));
		this.element.find("#btn-previous").click($.proxy(this._loadPreviuosCalendar,this));
	},
	
	_getCurrentDate : function (){
		var date = new Date();
		var formCalendar = {};
		this.today = date.getDate().toString() +'/' +  (date.getMonth() + 1).toString() + '/' + date.getFullYear().toString() ;
		formCalendar.date = this.today;
		formCalendar.actualPage = 0;
		return formCalendar;
	},
	
	_loadNextCalendar: function() {
		var formCalendar = {};
		formCalendar.date = this.week[6];
		formCalendar.actualPage = 1;
		this._loadEventsCallback(formCalendar);
	},
	
	_loadPreviuosCalendar : function() {
		var formCalendar = {};
		formCalendar.date = this.week[0];
		formCalendar.actualPage = -1;
		this._loadEventsCallback(formCalendar);
	},
	
	_loadEventsCallback: function(formCalendar) {
		var url = this.contextUrl + "/services/getEvents";
		$.ajax({
			url : url,
			type: "POST",
			data: JSON.stringify(formCalendar),
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			success : $.proxy(this._loadEvents, this),
			error : function() {
				alert("Error al obtener los eventos");
			}
		});
	},
	
	_loadEvents : function(data) {
		if(!data.error){
			this._loadThead(data.week, data.today);
			this._loadBody(data);
		} else{
			alert(data.message);
		}
	},
	
	_loadThead: function(week, today) {
		 this.week = week;
		 this.table.find("#sundayId").html('<div>' + this.week[0] + '</div>');
		 this.table.find("#mondayId").html('<div>' + this.week[1] + '</div>');
		 this.table.find("#tuesdayId").html('<div>' + this.week[2] + '</div>');
		 this.table.find("#wednesdayId").html('<div>' + this.week[3] + '</div>');
		 this.table.find("#thursdayId").html('<div>' + this.week[4] + '</div>');
		 this.table.find("#fridayId").html('<div>' + this.week[5] + '</div>');
		 this.table.find("#saturdayId").html('<div>' + this.week[6] + '</div>');
		 
		 if(this.week[0] == this.today){
			 this.table.find("#sundayId").parent().css({
				 backgroundColor : "#5bc0de"
			 });
		 }
		 else if(this.week[1] == this.today){
			 this.table.find("#mondayId").parent().css({
				 backgroundColor : "#5bc0de"
			 });
		 }
		 else if(this.week[2] == this.today){
			 this.table.find("#tuesdayId").parent().css({
				 backgroundColor : "#5bc0de"
			 });
		 }
		 else if(this.week[3] == this.today){
			 this.table.find("#wednesdayId").parent().css({
				 backgroundColor : "#5bc0de"
			 });
		 }
		 else if(this.week[4] == this.today){
			 this.table.find("#thursdayId").parent().css({
				 backgroundColor : "#5bc0de"
			 });
		 }
		 else if(this.week[5] == this.today){
			 this.table.find("#fridayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
		 }
		 else if(this.week[6] == this.today){
			 this.table.find("#suturdayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
		 } else {
			 this.table.find("#sundayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#mondayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#tuesdayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#wednesdayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#thursdayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#fridayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
			 this.table.find("#suturdayId").parent().css({
				 backgroundColor : "#337ab7"
			 });
		 }
	},
	
	_resetDivs: function() {
		this._removeEvents($("div.eventsSunday"));
		this._removeEvents($("div.eventsMonday"));
		this._removeEvents($("div.eventsTuesday"));
		this._removeEvents($("div.eventsWednesday"));
		this._removeEvents($("div.eventsThursday"));
		this._removeEvents($("div.eventsFriday"));
		this._removeEvents($("div.eventsSaturday"));
	},
	
	_loadBody: function(data) {
		
		this._resetDivs();
		
		if(data.eventsSunday.length > 0){
			for(var i = 0; i < data.eventsSunday.length; i++){
				var event = this._createEventDiv(data.eventsSunday[i], 0);
				$(event).appendTo(this.element.find('.columnSunday'));
			}
			this._createEventDrag(".dragEventsSunday", ".columnSunday");
			this._ordenarCeldas($("div.eventsSunday"));
			this._applyToolTips(".eventsSunday");
		} 
		
		if(data.eventsMonday.length > 0){
			for(var i = 0; i < data.eventsMonday.length; i++){
				var event = this._createEventDiv(data.eventsMonday[i], 1);
				$(event).appendTo(this.element.find('.columnMonday'));
			}
			this._createEventDrag(".dragEventsMonday", ".columnMonday");
			this._ordenarCeldas($("div.eventsMonday"));
			this._applyToolTips(".eventsMonday");
		}
		
		if(data.eventsTuesday.length > 0){
			for(var i = 0; i < data.eventsTuesday.length; i++){
				var event = this._createEventDiv(data.eventsTuesday[i], 2);
				$(event).appendTo(this.element.find('.columnTuesday'));
			}
			this._createEventDrag(".dragEventsTuesday", ".columnTuesday");
			this._ordenarCeldas($("div.eventsTuesday"));
			this._applyToolTips(".eventsTuesday");
		}
		
		if(data.eventsWednesday.length > 0){
			for(var i = 0; i < data.eventsWednesday.length; i++){
				var event = this._createEventDiv(data.eventsWednesday[i], 3);
				$(event).appendTo(this.element.find('.columnWednesday'));
			}
			this._createEventDrag(".dragEventsWednesday", ".columnWednesday");
			this._ordenarCeldas($("div.eventsWednesday"));
			this._applyToolTips(".eventsWednesday");
		} 
		
		if(data.eventsThursday.length > 0){
			for(var i = 0; i < data.eventsThursday.length; i++){
				var event = this._createEventDiv(data.eventsThursday[i], 4);
				$(event).appendTo(this.element.find('.columnThursday'));
			}
			this._createEventDrag(".dragEventsThursday" , ".columnThursday");
			this._ordenarCeldas($("div.eventsThursday"));
			this._applyToolTips(".eventsThursday");
		}
		
		if(data.eventsFriday.length > 0){
			for(var i = 0; i < data.eventsFriday.length; i++){
				var event = this._createEventDiv(data.eventsFriday[i], 5);
				$(event).appendTo(this.element.find('.columnFriday'));
			}
			this._createEventDrag(".dragEventsFriday", ".columnFriday");
			this._ordenarCeldas($("div.eventsFriday"));
			this._applyToolTips(".eventsFriday");
		} 
		
		if(data.eventsSaturday.length > 0){
			for(var i = 0; i < data.eventsSaturday.length; i++){
				var event = this._createEventDiv(data.eventsSaturday[i], 6);
				$(event).appendTo(this.element.find('.columnSaturday'));
			}
			this._createEventDrag(".dragEventsSaturday", ".columnSaturday");
			this._ordenarCeldas($("div.eventsSaturday"));
			this._applyToolTips(".eventsSaturday");
		}
	},
	
	_removeEvents : function(events){
		for(var i = 0 ; i < events.length; i++ ){
			events[i].remove();
		}
	},
	
	_createEventDiv : function(event, day) {
		var clazz="";
		if(day == 0){
			clazz = "eventsSunday";
			if(event.isOwner){
				clazz = clazz + " dragEventsSunday";
			}
			$div = $('<div class="' + clazz + '"></daiv>');
		}
		if(day == 1){
			clazz = "eventsMonday";
			if(event.isOwner){
				clazz = clazz + " dragEventsMonday";
			}
			$div = $('<div class="' + clazz + '"></div>');
		}
		if(day == 2){
			clazz = "eventsTuesday";
			if(event.isOwner){
				clazz = clazz + " dragEventsTuesday";
			}
			$div = $('<div class="'+ clazz +'"></div>');
		}
		if(day == 3){
			clazz = "eventsWednesday";
			if(event.isOwner){
				clazz = clazz + " dragEventsWednesday";
			}
			$div = $('<div class="' + clazz + '"></div>');
		}
		if(day == 4){
			clazz = "eventsThursday";
			if(event.isOwner){
				clazz = clazz + " dragEventsThursday";
			}
			$div = $('<div class="' + clazz + '"></div>');
		}
		if(day == 5){
			clazz = "eventsFriday";
			if(event.isOwner){
				clazz = clazz + " dragEventsFriday";
			}
			$div = $('<div class="' + clazz + '"></div>');
		}
		if(day == 6){
			clazz = "eventsSaturday";
			if(event.isOwner){
				clazz = clazz + " dragEventsSaturday";
			}
			$div = $('<div class="' + clazz + '"></div>');
		}
		
		
		$div.html(event.name); // Ojo el .html debe ir primero, por que sino reemplaza los appendTo()
		
		//startTime

		$inputStartTime = $('<input type="hidden" class="startTime">');
		$inputStartTime.val(event.startTime);
		$($inputStartTime).appendTo($div);
		
		//endTime
		
		$inputEndTime = $('<input type="hidden" class="endTime">');
		$inputEndTime.val(event.endTime);
		$($inputEndTime).appendTo($div);
		
		// name 
		
		$inputName = $('<input type="hidden" class="name">');
		$inputName.val(event.name);
		$($inputName).appendTo($div);
		
		$inputType = $('<input type="hidden" class="type">');
		$inputType.val(event.type);
		$($inputType).appendTo($div);
		
		$inputIndex = $('<input type="hidden" class="index">');
		$inputIndex.val(event.index);
		$($inputIndex).appendTo($div);
		$inputId = $('<input type="hidden" class="id">');
		$inputId.val(event.id);
		$($inputId).appendTo($div);
		$inputDate = $('<input type="hidden" class="date">');
		var fcolor  = this._getColorEvent(event);
		$div.css({
			color : "#FFFFFF",
			top: event.top + "px",
			height: event.height + "px",
			backgroundColor : fcolor
		});
		
		return $div;
	},
	
	_getColorEvent : function(event) {
		var color = "";
		if(event.type == "meeting" ){
			if(event.isOwner){
				color = "#006633"; // verde
			} else {
				if(event.isGuest){
					if(event.state == "1"){
						color = "#006633"; // verde
					} else if(event.state == "2"){
						color = "#FF0000"; //rojo
					} else { // pendientes 
						color = "#DAA520";
					}
				}
			}
		}
		if(event.type == "privateEvent"){
			color = "#000080"; // azul
		}
		return color;
	},
		
	_ordenarCeldas : function(events) {
			var matriz = new Array(48);
			for(var i = 0; i < matriz.length; i++){
				matriz[i] = new Array();
			}
			
			for(var i = 0; i < 48; i++){
				array = matriz[i];
				var top = this._obtenerTop(i);
				for(var j = 0; j< events.length; j++){
					var evento = $(events[j]);
					var positionEvent = this._getPosition(evento);
					if(positionEvent.top == top || (top > positionEvent.top && top < positionEvent.flat) ){
						array.push(evento); 
					}
				}
				if(array.length > 0){
					this._ordenarCeldaByIndex(array, top);
				}
			}
	},
	
	_obtenerTop: function (index) {
		var top = 0;
		for(var i = 0; i < 48; i++){
			if(i == index){
				return top;	
			}
			top+=20;
		}
	},
	
	_ordenarCeldaByIndex : function(array, top) {
		array.sort(function(argA, argB) {
			var a = $(argA);
			var b = $(argB);
			return parseInt(a.find(".index").val())
					- parseInt(b.find(".index").val());
		});
		this._desplazar(this._ordenarArray(array, top), top);
	},
	
	_ordenarArray: function(events, top) {
		var array = new Array();
		for(var i = 0; i < events.length; i++){
			var evento = $(events[i]);
			var positionEvent = this._getPosition(evento);
			if(array.length > 0){
				if(top != positionEvent.top){
					if(!array[evento.find(".index").val()]){
						array[evento.find(".index").val()] = evento;
					} else {// si la posicion del array2 i ya se encuentra ocupada igualmente la reemplazo por el evento de mayor prioridad y desplazo a los demas en 1 
						// logica para cuando tengo 2 eventos con el mismo indice, pero uno tiene mayor prioridad
						var arrayAux = new Array();
					    var aux = 0;
						for(var index = parseInt(evento.find(".index").val()); index < array.length; index++, aux++){
							arrayAux[aux] = array[index];
						}
						array[evento.find(".index").val()] = evento;
						arrayAux = this._ordenarArray(arrayAux, top);
						array = array.concat(arrayAux);
					}
					
				} else {
					for(var j = 0; j<array.length; j++){
						if(!array[j]){
							break;
						}
					}
					array[j] = evento;
				}
			} else {
				if(top != positionEvent.top){
					array[evento.find(".index").val()] = evento;
				} else {
					array[0] = evento;
				}
			}
		}
		return array;
	},
	
	_desplazar : function (array, top) {
		for (var i = 0; i < array.length; i++) {
			if(array[i])
			{
				evento = $(array[i]);
				positionEvent = this._getPosition(evento);
				if(positionEvent.top == top){
					evento.find(".index").val(i);
					var index = i + 1;
					var left = this._obtenerDesplazamiento(index);
					evento.css({
						zIndex : index,
						left : left + "px"
					});	
				}	

			}
		}
	},
	
	_ordenarCeldaActual : function (drag, clazz) {
		drag.removeClass(clazz);
		var events = $('div.'+clazz);
		var array = new Array();
		var positionDrag = this._getPosition(drag);
		for (var i = 0; i < events.length; i++) {
			var evento = $(events[i]);
			positionEvent = this._getPosition(evento);
			if ((positionEvent.top == positionDrag.top || this._existeColisionCeldaActual(positionEvent, positionDrag)) && this._existeIndice(array, evento.find(".indice").val())) {
				if(positionEvent.top != positionDrag.top){
					array[evento.find(".index").val()] = evento;
				} else {
					if(array.length > 0){
						for(var j = 0; j < array.length; j++){
							if(!array[j]){
								break;
							}
						}
						array[j] = evento;
						
					} else {
						array[0] = evento; 
					}
				}
			}
		}
		var index = this._getIndexLibre(array);
		drag.find(".index").val(index);
		index = index + 1;
		var left = this._obtenerDesplazamiento(index);
		drag.css({
			left : left + "px",
			zIndex : index,
		});
		drag.find(".top").val(positionDrag.top);
		
		drag.addClass(clazz);
	},
	
	_getPosition : function (object){
		var pos = 0;
		var position = {};
		pos = object.css("top").indexOf("px");
		position.top = parseInt(object.css("top").substring(0,pos));
		pos = object.css("height").indexOf("px");
		position.height = parseInt(object.css("height").substring(0,pos));
		position.flat = position.top + position.height;
		return position;
	},
	
	_existeIndice : function (array, index){
		for(var i = 0; i < array.length; i++){
			if(array[i]){
				if(array[i].find(".index").val() == index){
					return false;
				}
			}
		}
		return true;
	},
	
	_existeColisionCeldaActual : function (positionEvent, positionDrag) {
		if(positionEvent.height > positionDrag.height){
			return  positionEvent.top < positionDrag.top && positionEvent.flat > positionDrag.flat;
		} else {
			return   positionEvent.top > positionDrag.top && positionEvent.flat < positionDrag.flat;
		}
	},

	_getIndexLibre : function (array) {
		var index = 0;
		for (var i = 0; i < array.length; i++) {
			if (!array[i]) {
				index = i;
				return index;
			}
		}
		return i;
	},

	_obtenerDesplazamiento : function (index) {
		var left = -20;
		for (var i = 0; i < index; i++) {
			left = left + 20;
		}
		return left;
	},
	
	destroy : function() {
		for ( var name in this.calls) {
			this.calls[name].abort();
			this.calls[name] = null;
		}

		if (typeof (CollectGarbage) == "function") {
			CollectGarbage();
		}
	}

});
