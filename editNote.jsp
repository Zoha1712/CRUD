<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String noteText="", fontStyle="Poppins", fontColor="#000000", bgColor="#ffffff";

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notesdb","root","");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM notes WHERE id=?");
        ps.setInt(1,id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            noteText = rs.getString("noteText");
            fontStyle = rs.getString("fontStyle");
            fontColor = rs.getString("fontColor");
            bgColor = rs.getString("bgColor");
        }
        rs.close(); ps.close(); con.close();
    } catch(Exception e){ e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Note</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
    <div class="container">
        <h2>Edit Note</h2>
        <form action="updateNote.jsp" method="post">
            <input type="hidden" name="id" value="<%=id%>">
            <div class="mb-3">
                <textarea name="noteText" class="form-control" rows="4" style="font-family:<%=fontStyle%>; color:<%=fontColor%>; background:<%=bgColor%>;"><%=noteText%></textarea>
            </div>
            <div class="mb-3 d-flex justify-content-between">
                <select name="fontStyle" class="form-select w-50 me-2">
                    <option value="Poppins" <%= "Poppins".equals(fontStyle)?"selected":"" %>>Poppins</option>
                    <option value="Arial" <%= "Arial".equals(fontStyle)?"selected":"" %>>Arial</option>
                    <option value="Times New Roman" <%= "Times New Roman".equals(fontStyle)?"selected":"" %>>Times New Roman</option>
                    <option value="Cursive" <%= "Cursive".equals(fontStyle)?"selected":"" %>>Cursive</option>
                </select>
                <input type="color" name="fontColor" class="form-control form-control-color me-2" value="<%=fontColor%>">
                <input type="color" name="bgColor" class="form-control form-control-color" value="<%=bgColor%>">
            </div>
            <button type="submit" class="btn btn-primary">Update Note</button>
        </form>
    </div>
</body>
</html>
