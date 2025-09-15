<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8"); // Unicode support

    String noteText = request.getParameter("noteText");
    String fontStyle = request.getParameter("fontStyle");
    String fontColor = request.getParameter("fontColor");
    String bgColor = request.getParameter("bgColor");

    if(noteText != null && !noteText.trim().isEmpty()){
        Connection con = null;
        PreparedStatement ps = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/notesdb","root","");

            ps = con.prepareStatement("INSERT INTO notes(noteText,fontStyle,fontColor,bgColor) VALUES(?,?,?,?)");
            ps.setString(1, noteText);
            ps.setString(2, fontStyle);
            ps.setString(3, fontColor);
            ps.setString(4, bgColor);
            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    response.sendRedirect("Main_page.jsp"); // redirect back
%>
