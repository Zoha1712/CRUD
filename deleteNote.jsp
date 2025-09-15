<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notesdb","root","");
        PreparedStatement ps = con.prepareStatement("DELETE FROM notes WHERE id=?");
        ps.setInt(1,id);
        ps.executeUpdate();
        ps.close();
        con.close();
    } catch(Exception e){ e.printStackTrace(); }
    response.sendRedirect("Main_page.jsp");
%>
