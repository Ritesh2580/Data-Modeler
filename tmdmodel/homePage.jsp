﻿<%@ taglib prefix="tm"  uri="/WEB-INF/tlds/c.tld" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin - Dashboard</title>
    <!-- Bootstrap core CSS-->
    <link href="/tmdmodel/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/tmdmodel/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
type="text/css">

    <!-- Page level plugin CSS-->
    <link href="/tmdmodel/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/tmdmodel/css/sb-admin.css" rel="stylesheet">
<script>
function changeDropdown(a)
{ 
var dropdownButton=document.getElementById("dropdownButton");
dropdownButton.value=a.innerHTML;
dropdownButton.innerHTML=a.innerHTML;
document.getElementById("databaseArchitectureHiddenText").value=a.innerHTML;

}
function processProjectForm()
{
var projectForm=$('#projectModalForm');
var title=projectForm.find('#projectTitle');
var dropDown=projectForm.find('#dropdownButton');
var errors=0;
if((title.val().trim()).length==0||title.val()==null)
{
errors++;
title.addClass("is-invalid");
title.focus();
}
else
{
title.removeClass("is-invalid");
}
if((dropDown.val().trim()).length==0||dropDown.val()==null||(dropDown.val()).upper()=='DATABASE ARCHITECTURE')
{
errors++;
dropDown.addClass("is-invalid");
dropDown.focus();
}
else
{
dropDown.removeClass("is-invalid");
}
if(errors==0)
{
alert(errors);
return true;
}
else 
{
alert(errors);
return false;
}
return false;
}
function setProject()
{
alert(document.getElementById("projectList").value);
document.getElementById('openProjectText').value=document.getElementById("projectList").value;
}
function processOpenProjectForm()
{
if(document.getElementById("openProjectText").value()!=null|| (document.getElementById("openProjectText").value().trim()).length!=0)return true;
return false;
}
</script>
<style>
.selectedProject
{
 background-color:#28A4D4;
color:black;
opacity: 0.5;
}
</style>
</head>

  <body id="page-top">

    <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
 <a class="navbar-brand mr-1" href="index.html">TMD model</a>

      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
      </button>

     
 
    	
      <ul class="navbar-nav ml-auto ml-md-9">
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-bell fa-fw"></i>
            <span class="badge badge-danger">9+</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="alertsDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow mx-1">
          <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-envelope fa-fw"></i>
            <span class="badge badge-danger">7</span>
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
            <a class="dropdown-item" href="#">Action</a>
            <a class="dropdown-item" href="#">Another action</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">Something else here</a>
          </div>
        </li>
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         <i class="fas fa-user-circle fa-fw"></i>${member.firstName}
          </a>
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#">Settings</a>
            <a class="dropdown-item" href="#">Activity Log</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="/tmdmodel/webservice/memberService/logout" data-toggle="modal" data-target="#logoutModal">Logout</a>
          </div>
        </li>
      </ul>

    </nav>

<div id="wrapper">
<!-- Sidebar -->
<ul class="sidebar navbar-nav">
<li class="nav-item active">
          
<span class="nav-link"> Number of project: ${member.numberOfProjects}</span>
    
</li>
<li class="nav-item active">
          
<a class="nav-link" href='#' data-toggle='modal' data-target='#createProjectModal' data-backdrop='static' data-keyboard='false' >
                    
<span>New project</span>
       
</a>
</li>
<li class='nav-item active'>
<a class='nav-link' href='#' data-toggle='modal' data-target='#openProjectModal' data-backdrop='static' data-keyboard='false' >
<span>Open project</span>
</a>
</li>         
        <li class="nav-item">
          <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Charts</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="tables.html">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span></a>
        </li>
      </ul>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Area Chart Example-->
          <div class="card mb-3">
             
            <div class="card-body">

            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
    </div>
         
        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © Your Website 2018</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    </div>


    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>


    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="/tmdmodel/login.jsp">Logout</a>
          </div>
        </div>
      </div>
    </div>

<!-- create project modal-->
<div class="modal fade" id="createProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<form action='/tmdmodel/webservice/projectService/createProject' id='projectModalForm' method='post' onsubmit='return processProjectForm()' novalidate>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Create Project</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">
<!--Things to be done here-->
<div class='form-group' id='emailAddressGroup'>
<div class='form-label-group'>
<input type='text' id='projectTitle' placeholder='Title' name='argument-1' required='required' class='form-control'>
<label for='projectTitle'>Title</label>
<div class="invalid-feedback">Title required</div>
</div>
</div>

<div class='dropdown'>
<div class='form-row'>
<div class='col-md-2 col-lg-2'> 
<button class='btn btn-primary dropdown-toggle' id='dropdownButton'   type='button' data-toggle='dropdown' value=''  class='form-control'>Database  
<span class='caret'></span></button>
<ul class='dropdown-menu col-md-2 col-lg-2 ' style="text-align: center;">
<tm:forEach items='${architectures}' var='architecture' >
<li ><a href='#'  onclick=changeDropdown(this)>${architecture.name}</a></li>
</tm:forEach>
</ul>

<input type='hidden' id='databaseArchitectureHiddenText' value=' ' name='argument-2'  >
</div>
</div>
</div>
</div>



<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<input type='submit' class="btn btn-primary" value='Create'>
</div>
</div>
</div>
</form>
</div>





<div class="modal fade" id="openProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<form action='/tmdmodel/webservice/projectService/openProject' id='projectModalForm' method='post' onsubmit='return processOpenProjectForm()' novalidate>
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Create Project</h5>
<button class="close" type="button" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">×</span>
</button>
</div>
<div class="modal-body">
<div class='card-body'>
<div class='form-group'>
<label for="projectsList">Select project:</label>
<select class="form-control" id="projectList">
<tm:forEach items='${memberProjects}' var='project' >
 <option ><a class='nav-link' href='#' ><tm:out value='${project.title}'/></a></option>
</tm:forEach>
</select>
</div>
</div>
</div>
<input type='hidden' id='openProjectText' value=' ' name='argument-1'>
<div class="modal-footer">
<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
<input type='submit' class="btn btn-primary"  onclick=setProject() value='Open'>
</div>
</div>
</div>
</form>
</div>


    <!-- Bootstrap core JavaScript-->
    <script src="/tmdmodel/vendor/jquery/jquery.min.js"></script>
    <script src="/tmdmodel/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/tmdmodel/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="/tmdmodel/vendor/datatables/jquery.dataTables.js"></script>
    <script src="/tmdmodel/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/tmdmodel/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="/tmdmodel/js/demo/datatables-demo.js"></script>
   
  </body>

</html>
