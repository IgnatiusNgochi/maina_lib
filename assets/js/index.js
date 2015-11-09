$(document).ready(function(){
     $('#tbl').DataTable();
	var loading = "loading_gif";
	setLoading(loading, false)
});



$(function() {
    $("#xlsxFile").change(function(event) {
		var loading = "loading_gif";
		setLoading(loading, true);
		setResponse('loading', 'Processing Workbook....');
		
		
		
        var file = this.files[0],  sheets;
        XLSXReader(file, true, function(xlsxData) {
            sheets = xlsxData.sheets;
            //console.log(JSON.stringify(sheets));
			
			var $sheet_name = $('#sheet_name');
			var options = '<option value="">---- Select a sheet ----</option>';
			
			for(s in sheets){
				//console.log(s);
				options = options +  '<option value="' + s + '"> ' + s + '</option>';
			}
			$sheet_name.html(options);
			
			$sheet_name.on('change', function() {
				var sheet =  $(this).val();
				//console.log(JSON.stringify(sheets[sheet]['row_size']));
				previewSheet(sheets[sheet]['data'], sheets[sheet]['row_size'], sheets[sheet]['col_size']);
			});
			
			setLoading(loading, false);
			setResponse('success', 'Finished Processing Workbook');
        });
    });
});



function previewSheet(data, rows, cols){
	var $tbl = $('#tbl');
	
	var commands = '';
	
	console.log('Rows : ' + rows);
	console.log('Cols : ' + cols);
	
	//var button = '<button type="button" id="btnAddToPNR" onclick="addToPNR(' + data + ')" class="btn btn-success">Add To PNR</button><br /><br />';
	
	var table = '<table id="tblPeople" class="table table-bordered table-striped" >'
					+'<thead><tr>'
							+ '<th > &nbsp; # </th>'
							+ '<th>Last Name </th>'
							+ '<th>First Name</th>'
							/*+ '<th>Salutation</th>'
							+ '<th>Passport/ID No.</th>'
							+ '<th>Phone</th>'*/
							//+ '<th>Add To PNR</th>'
					+'</tr></thead><tbody>';
					
				
	
	var tbody = '';
	for(var i = 0; i < rows; i++){
		var name = data[i][0] + '/' + data[i][1] + '' + data[i][2];

		var tr = '<tr >'
					+ '<td > <input type="checkbox" onchange="checkboxToggle()" '
						+ ' data-name="' + name + '"'
						+ ' data-phone="' + data[i][4] + '"'
						+ ' data-id="' + data[i][3] + '" >'
					+ '</td>'
					+ '<td > ' + data[i][0] + ' </td>'
					+ '<td > ' + data[i][1] + ' </td>'
					/*+ '<td > ' + data[i][2] + ' </td>'
					+ '<td > ' + (data[i][3] == undefined ? "Not Set": data[i][3]  ) + ' </td>'
					+ '<td > ' + (data[i][4] == undefined ? "Not Set": data[i][4]  ) + ' </td>'*/
 				/*+ '<td > '
						+'<button type="button" class="btn btn-success btn-xs" '
 							+ ' data-name="' + name + '"'
 							+ ' data-phone="' + data[i][4] + '"'
 							+ ' data-id="' + data[i][3] + '"'
 						+ ' onclick="addToPNR(this)" >'
 					+ '<span class="glyphicon glyphicon-plus"></span> Add To PNR</button> 
                            +'</td>' */
						
					+'</tr>';	
		var tbody = tbody + tr;		
	}
	table = table + tbody + '</tbody></table>';
	
	$tbl.html(table);
	
	
	
	
	console.log(data);
   /* JSON.stringify(data);*/
    var json = JSON.stringify(data);
    
}

$('#btnAddSelected').click(function(e){
	var loading = "loading_gif";
	setLoading(loading, true);
	setResponse('loading', 'Adding To PNR.....');
	
	$('#tblPeople tbody tr').each(function(i, row){
		var $row = $(row);
		var $checkedBox = $row.find('input:checked');		
		var $chkUseId = $('#chkUseId');
		var $chkUsePhone  = $('#chkUsePhone');
		
		var name = $checkedBox.attr('data-name');
		var phone = $checkedBox.attr('data-phone');
		var id = $checkedBox.attr('data-id');
		
		if($checkedBox.is(':checked')){
			var com_name = 'N.' + name;
			executeCommand(com_name);
			
			if($chkUsePhone.is(':checked')){
				if(!phone == undefined || phone != "undefined"){
					var com_phone = 'P.NBOH*' + phone;
					executeCommand(com_phone);
				}
			}
			
			if($chkUseId.is(':checked')){
				if(!id == undefined || id != "undefined"){
					//var com_name = 'N.' + name;
					//executeCommand(com_name);
					//TODO ce
				}
				

			}
			
		}
	});
	
	setLoading(loading, false);
	setResponse('success', 'Finished Adding to PNR');
	
	
});


function checkboxToggle(){
	
	$('#tblPeople tbody tr').each(function(i, row){
		var $row = $(row);
		$checkedBox = $row.find('input:checked');
		$row.removeClass('success');
		if($checkedBox.is(':checked')){
			$row.addClass('success');
		}else{
			$row.removeClass('success');
		}
	});
	
}				





function toggleAll(chk){
	var $chk = $(chk);
	var $txt = $('#spnToggle');
	if($chk.is(':checked')){
		$txt.html('Unselect All');
	}else{
		$txt.html('Select All');
	}

	$('#tblPeople tbody tr').each(function(i, row){
		var $row = $(row);
		$checkBox = $row.find('input:checkbox');
		
		$checkBox.prop('checked', $chk.is(':checked')).change();
		
// 		if($checkedBox.is(':checked')){
// 			$row.addClass('success');
// 		}else{
// 			$row.removeClass('success');
// 		}
	});
}

function addToPNR(btn){
	var $this = $(btn);
	var cmd = 'N.' + $this.attr('data-name');
	executeCommand(cmd);
}

function executeCommand(cmd){
	var TE = new ActiveXObject("DAT32COM.TERMINALEMULATION");
	var command = "<FORMAT>" + cmd + "</FORMAT>";
	TE.MakeEntry(command);
}


function setResponse(type, message){
	document.getElementById("response").innerHTML = message;
	if(type == 'success'){
		document.getElementById('response').style.color = '#6FBC57';
	}else if(type == 'error'){
		document.getElementById('response').style.color = '#d9534f';
	}else if(type == 'loading'){
		document.getElementById('response').style.color = '#009DDC';
	}
}

function setLoading(id, visible) {
    var img = document.getElementById(id);
    img.style.visibility = (visible ? 'visible' : 'hidden');
} 
