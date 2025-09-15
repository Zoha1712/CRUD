<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Poppins', sans-serif; color: white; min-height: 100vh;
               background: linear-gradient(270deg,#4b0082,#8a2be2,#9370db,#9400d3); background-size:800% 800%; animation: gradientBG 20s ease infinite; }
        @keyframes gradientBG {0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}
        .navbar { background: rgba(0,0,0,0.2); backdrop-filter: blur(10px); }
        .navbar-brand { font-size:24px; font-weight:bold; color:white; }
        .add-btn { position: fixed; bottom:30px; right:30px; background:#ff6bcb; color:white; border:none; border-radius:50%; width:65px; height:65px; font-size:30px; box-shadow:0 4px 12px rgba(0,0,0,0.3);}
        .add-btn:hover { background:#ff4fbf; }
        .note-card { border-radius:8px; padding:15px; margin:15px 0; color:black; transition:background 0.3s;}
        .note-card:hover { background:#ffc0cb; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid d-flex justify-content-center">
        <a class="navbar-brand" href="#">HOME</a>
    </div>
</nav>

<div class="container text-center mt-5">
    <h1>Welcome to Your Notes 🐾</h1>
    <p>Add, Edit & Delete your notes here 😺</p>

    <!-- Notes Display -->
    <div id="notesContainer" class="mt-4">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notesdb","root","");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM notes ORDER BY id DESC");

            while(rs.next()){
    %>
        <div class="note-card" style="font-family:<%=rs.getString("fontStyle")%>; color:<%=rs.getString("fontColor")%>; background:<%=rs.getString("bgColor")%>;">
            <p><%= rs.getString("noteText") %></p>
            <a href="editNote.jsp?id=<%=rs.getInt("id")%>" class="btn btn-sm btn-warning">Edit</a>
            <a href="deleteNote.jsp?id=<%=rs.getInt("id")%>" class="btn btn-sm btn-danger">Delete</a>
        </div>
    <%
            }
            con.close();
        } catch(Exception e){ e.printStackTrace(); }
    %>
    </div>
</div>

<!-- Floating Add Button -->
<button class="add-btn" data-bs-toggle="modal" data-bs-target="#noteModal">
    <i class="fa-solid fa-plus"></i>
</button>

<!-- Modal for Adding Notes -->
<div class="modal fade" id="noteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content text-dark">
            <div class="modal-header">
                <h5 class="modal-title">Add Note</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="saveNote.jsp" method="post">
                    <div class="mb-3">
                        <textarea id="noteText" name="noteText" class="form-control" rows="4" placeholder="Write your note..." required></textarea>
                    </div>
                    <div class="mb-3 d-flex justify-content-between">
                        <select id="fontStyle" name="fontStyle" class="form-select w-50 me-2">
                            <option value="Poppins">Poppins</option>
                            <option value="Arial">Arial</option>
                            <option value="Times New Roman">Times New Roman</option>
                            <option value="Cursive">Cursive</option>
                        </select>
                        <input type="color" id="fontColor" name="fontColor" class="form-control form-control-color me-2" value="#000000">
                        <input type="color" id="bgColor" name="bgColor" class="form-control form-control-color" value="#ffffff">
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById("fontStyle").addEventListener("change", ()=>{document.getElementById("noteText").style.fontFamily=document.getElementById("fontStyle").value;});
document.getElementById("fontColor").addEventListener("input", ()=>{document.getElementById("noteText").style.color=document.getElementById("fontColor").value;});
document.getElementById("bgColor").addEventListener("input", ()=>{document.getElementById("noteText").style.backgroundColor=document.getElementById("bgColor").value;});
</script>

</body>
</html>
