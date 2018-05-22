<link rel="stylesheet" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css"/>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
<link href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />

<!-- 5 include the minified jstree source -->
<script src="jstree/dist/jstree.min.js"></script>
<!-- 2 load the theme CSS file -->
<link rel="stylesheet" href="jstree/dist/themes/default/style.min.css" />

 <script src="chosen/chosen.jquery.js"></script>
 <link rel="stylesheet" href="chosen/chosen.css">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
 <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
 <head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="resolution.css">
 <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
 <title>Equipment Configuration Report</title>
 </head>
<style>

@media only screen and (max-width: 700px) {
   style-element {
      font-size: 20px;
   }
}

@media only screen and (max-width: 320px) {
   style-element {
     font-size: 10px;
   }
}

body, html {
	overflow:auto; 
}
body {
      
      /*font-size: 100%;
      line-height: 1.6875;
      font-family: 'Tangerine', serif;
      font-size:medium;
      padding:15px;
      margin-bottom:2%;
      margin:2%;
      /*border:1px solid grey;
       overflow:hidden; 
      transform: scale(1.1);
      transform-origin: 10% 10%;
      background-color:none;
      border: 5px solid transparent; */
      
      position: fixed;
  	  width: 75%;
   	  height: 75%;
      padding:15px;
      margin-bottom:2%;
      margin:2%;
    
      
     }

 th { text-align: center ; font-size:small}
 td { text-align: right; font-size:small }

 table tbody td {
    min-width: 100px;
    width:auto;
    height: 75%;
    
}
#dtree {
	float:left;
	width:25%;
	overflow: auto;
	height:75%;
	min-width: 15%;
	border-right: 1px solid silver;;
	margin:0 10px 10px 0;
	font-size:initial;
	

}
.jstree-default .jstree-node {
  	min-height: 24px;
 	line-height: 24px;
 	margin-left: 24px;
 	min-width: 24px;
  	font-size: initial;
  	font-family: serif;
}

#dtable {
	float:left;
	width:85%;
	overflow: auto;
	height: 75%;
	min-width: 15%;
	border-right: 1px solid silver;
	margin:0 10px 10px 0;
	overflow:auto; 

 
}

a:link {
    display:inline-block;
  
}

li a{
  cursor: pointer; cursor: hand;
}
   a:hover { border-color: #ccc; }
  .ui-widget-content { border: none; background:none}
  .ui-tabs-vertical { width: 45em; }
  .ui-tabs-vertical {
      background-color: transparent; 
      display: block; 
      color: #3472a4; 
      font-size: medium; 
      font-weight: bold; 
      text-transform: uppercase; 
      padding: 5px 10px;
      text-shadow: none;
      border-top: 1px solid #3472a4;
      border-bottom: 1px solid #3472a4;
      border-left: 1px solid #3472a4;
  
  }
  .ui-tabs-vertical .ui-tabs-nav { padding: .2em .1em .2em .2em; float: left; width: 12em; }
  .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; }
  .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
  .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; }
  .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 40em;}
  .chosen-container .chosen-container-multi {width: 50%; }
  .chosen-container { width: 220px !important; }
  .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active {
 	 border: 1px solid #aaaaaa;
  	background: none;
  	font-weight: normal;
  	color: Blue;
  	font-size:medium;
  }

</style>
<script>


$(document).ready(function() {
	$( "#tabs" ).tabs({
	      event: "mouseover",
	    	  activate: function (event, ui) {
	    	        var oTable = $('div.dataTables_scrollBody>table:visible', ui.panel).dataTable();
	    	        if (oTable.length > 0) {
	    	            oTable.fnAdjustColumnSizing();
	    	        }
	    	    }
	      
	 });
	
	 var posting = $.post("getDefaultSelect.jsp");
	  posting.done(function(data) {
		  
		  $('#dtree').empty().append(data);
		  $('#dtree').jstree();
		 
		  
		
	  });
	  
	  
	  var posting = $.post("getDefaultTable.jsp");
	  posting.done(function(data) {
		  
		  $('#dtable').empty().append(data);
		
		  var table = $('div > #example').DataTable( {
			   "sScrollY": "80%",
			   "sScrollX": "100%",
		        "sScrollXInner": "110%",
		        "bScrollCollapse": true 
		  });
		
	  });
	  
	  
	  var posting = $.post("getDefaultSelectReverse.jsp");
	  posting.done(function(data) {
		  
		  $('#dtreeR').empty().append(data);
		  $('#dtreeR').jstree();
		 
		  
		
	  });
	  
	  
	  var posting = $.post("getDefaultTableReverse.jsp");
	  posting.done(function(data) {
		  
		  $('#dtableR').empty().append(data);
		
		  var tableR = $('div > #exampleR').DataTable( {
			   "sScrollY": "80%",
			   "sScrollX": "100%",
		        "sScrollXInner": "110%",
		        "bScrollCollapse": true
		  });
		
	  });
	  
	  
	  
	  
	  
	  var aposting = $.post("getAbridgedWTS.jsp");
	  aposting.done(function(data) {
		  
		  $('#dtable-wts').empty().append(data);
		  	var wtstable = $('div > #wts').DataTable( {
		  		
			    
			   
		  		
			  
		  });
	  });
	  
	  var bposting = $.post("getAbridgedTCT.jsp");  
	  bposting.done(function(data) {
		  $('#dtable-tct').empty().append(data);
		  	 var tcttable = $('div > #tct').DataTable( {
		  		
				
		  });
	});
	
	  
	  
	  var cposting = $.post("getAbridgedTCT22.jsp");  
	  cposting.done(function(data) {
		  $('#dtable-tct22').empty().append(data);
		  	 var tct22table = $('div > #tct22').DataTable( {
		  		
			   
		  });
	});
	
	  
	  var cposting = $.post("getLicenses_1.jsp");  
	  cposting.done(function(data) {
		  $('#dtable-licenses').empty().append(data);
		  	 var licensetable = $('div > #licenses').DataTable( {
		  		
			   
		  });
	});
	 
	  
	  
	  //update the display of the selected id 
	    $("#tabs").click(function(e){
	    	var aa = getSelectedTabId();
	    	
	    if ( aa === "tabs-1") {
	    	
	    	
	      
	        
	    } else if ( aa === "tabs-2") {
	    	
	    
	    	
	    }
	    });
    
   
} );

function getSelectedTabId(){
    return $("#tabs .ui-tabs-panel:visible").attr("id");
}


function fnShowHide( iCol )
{
	//alert(iCol);
    /* Get the DataTables object again - this is not a recreation, just a get of the object */
    var qTable = $('#example').dataTable();
     
    var bVis = qTable.fnSettings().aoColumns[iCol].bVisible;
    qTable.fnSetColumnVis( iCol, bVis ? false : true );
    
    
    var qTableR = $('#exampleR').dataTable();
    
    var bVisR = qTableR.fnSettings().aoColumns[iCol].bVisible;
    qTableR.fnSetColumnVis( iCol, bVisR ? false : true );
}
</script>


<div id="tabs" style="width: 80%;padding-bottom:20px;">
  <ul>
    <li><a href="#tabs-1">4080</a></li>
    <li><a href="#tabs-2">93000</a></li>
    <li><a href="#tabs-3">ULTRAFLEX</a></li>
    <li><a href="#tabs-4">LICENSE</a></li>
    <li><a href="#tabs-5">EXPANDED</a></li>
    <li><a href="#tabs-6">EXPANDED_INVERTED</a></li>
  </ul>
  
  <div id = "tabs-1"> 
  <div id = "dtable-wts" style="float: left;width: 80%;">
	<table id="wts" class="display compact" cellspacing="0" width="100%"></table>
 </div> 
 </div>
 
  <div id = "tabs-2"> 
  <div id = "dtable-tct" style="float: left;width: 80%;">
	<table id="tct" class="display compact" cellspacing="0" width="100%"></table>
 </div> 
 </div>
   
  <div id = "tabs-3"> 
  <div id = "dtable-tct22" style="float: left;width: 80%;">
	<table id="tct22" class="display compact" cellspacing="0" width="100%"></table>
 </div> 
 </div>

		
 <div id = "tabs-4"> 
	<div id = "dtable-licenses" style="float: left;width: 80%;">
	<table id="licenses" class="display compact" cellspacing="0" width="100%"></table>
</div>
</div>

 <div id = "tabs-5"> 
	<div id = "dtree" style="float: left; width: 25%;"></div>
	<div id = "dtable" style="float: left;width: 70%;">
	<table id="example" class="display compact; width=100%;height=90%;border-collapse: collapse" ></table>
	<p> </p>
</div>
</div>

 <div id = "tabs-6"> 
	<div id = "dtreeR" style="float: left; width: 25%;"></div>
	<div id = "dtableR" style="float: left;width: 70%;">
	<table id="exampleR" class="display compact; width=100%;height=90%;border-collapse: collapse" ></table>
	<p> </p>
</div>
</div>

</div>