<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  

	request.setCharacterEncoding("UTF-8");
   
    String userId = request.getParameter("userId"); 
    String userName = request.getParameter("userName");
    String userPass = request.getParameter("userPass");
    String userEmail = request.getParameter("userEmail");
    String userSsn1 = request.getParameter("userSsn1");
    String userSsn2 = request.getParameter("userSsn2");
    String userSsn = userSsn1+"-"+userSsn2;
    
    String userZipCode1 = request.getParameter("userZipCode");
    String userAddr1 = request.getParameter("userAddr1");
    String userAddr2 = request.getParameter("userAddr2");
    String userZipCode = userZipCode1 + " " + userAddr1 + "," + userAddr2;
    
    
    String userPhone = request.getParameter("userPhone");
	
    
	//out.print(id + "/"+pwd + "/"+name + "/"+age + "/"+gender + "/"+email);
	//out.print(request.getRemoteAddr());
	
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = null;
	PreparedStatement pstmt=null;
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","bituser","1004");
		String sql="insert into KOREAMEMBER2(userId,userName,userPass,userEmail,userSsn,userZipCode,userPhone,ip) values(?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, userId);
		pstmt.setString(2, userName);
		pstmt.setString(3, userPass);
		pstmt.setString(4, userEmail);
		pstmt.setString(5, userSsn);
		pstmt.setString(6, userZipCode);
		pstmt.setString(7, userPhone);
		pstmt.setString(8, request.getRemoteAddr());
		
		int result = pstmt.executeUpdate();
		if(result !=0){
			out.print("<script>");
				out.print("location.href='Ex02_JDBC_Login.jsp'");	
			out.print("</script>");
		}else{ //실행될 확률 거의없다 ...
		}
		
	}catch(Exception e){
		// pstmt.executeUpdate(); 실행시  PK 위반 예외 발생    if 타지 않고 ....
		out.print("<script>");
			out.print("alert('가입실패');");	
			out.print("location.href='Ex02_JDBC_JoinForm.jsp'");	
		out.print("</script>");
	}finally{
		if(pstmt != null){ try{pstmt.close();}catch(Exception e){} }
		if(conn != null){ try{conn.close();}catch(Exception e){} }
	}
	
%>










