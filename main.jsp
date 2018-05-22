<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resolution.css">
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
<title>Equipment Configuration Report</title>
</head>
<style>
/* tell the container's children to float left: */
.float-my-children > * {
    float:left;
    margin-right:5px;
    padding-right:350px;
    padding-left:75px;
    margin:10px;
}

/* this is called a clearfix. it makes sure that the container's children floats are cleared, without using extra markup */

.clearfix {
    *zoom:1 /* for IE */
}

.clearfix:before,
.clearfix:after {
    content: " ";
    display: block;
}

.clearfix:after {
    clear: both;
}



body, html, table {
	overflow:auto;
}
/* end clearfix*/

/* below is just to make things easier to see, not required */
body {
 /*background-color:rgba(0,0,0,0.05);*/
 	font-family: serif;
 	font-size:medium;
 	margin-left: auto;
 	margin-right: auto;
 	width: 100%;
 	text-align: left;
 	height:100vh;
    overflow:auto;
     
}
body > div#root {
   position: fixed;
   width: 100%;
   height:100vh;
   margin-left: auto;
   margin-right: auto;
   overflow:auto;
  
}

/* iframe itself */
div#root > iframe {
    display: block;
   /* border: 2px grey solid;*/ 
    background-color:white;
    margin-left: auto;
	margin-right: auto;
	width: 105%;
	text-align: left;
	font-size:medium;
	height:100vh;
	overflow:auto;
	
}
body > div#banner {
    padding-top : 10px;
    margin-top:10px;
    border:1px dashed red;
    margin-bottom:2px;    
    background-color:grey;
}

</style>
<body>
<div id=root>
<div id=banner class="clearfix float-my-children">
<a href= http://fc8twebp01/intranet/>
  <!--   <img src="https://www.google.com/a/globalfoundries.com/images/logo.gif?alpha=1&amp;service=google_default" style="max-width:144px;max-height:60px">-->
   <img src="lib_web/img/globalfoundries/globalfoundries_small4.png" alt="GLOBALFOUNDRIES" >
   
   </a>
   
    <div >
  	  <h2>Tool Facts Configuration - Information Display Board</h2>
   </div>
   
   <div style="float:right">
   Welcome <%=request.getAttribute("hello").toString()%> 
   </div>

</div>

<iframe  src="index.jsp"  >
</iframe>
</div>
</body>
</html>