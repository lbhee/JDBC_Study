<%@page import="kr.or.bit.utils.Singleton_Helper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	//Class.forName("oracle.jdbc.OracleDriver"); tomcat 6.0 생략 가능
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		
		//conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","bituser","1004");
		//비기능적 요구사항
		conn = Singleton_Helper.getConnection("oracle");
		String sql="select userId, userPass from KOREAMEMBER2 where userId=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery(); 
		
		//업무
		while(rs.next()){
			//데이터가 있다 (id가 존재)
			
			//ID 존재
			if(pwd.equals(rs.getString("userPass"))){
			  //ID 존재 , PWD(0) 
			  //정상회원
			  
			  //Top.jsp 정보 로그인 상태 ...
			  session.setAttribute("userid", rs.getString("userId"));
			  
			  //이동처리
			  response.sendRedirect("Ex02_JDBC_Main.jsp");
			}
		}
		//while 타지 않는 경우
		out.print("<script>");
					out.print("alert('아이디, 비밀번호를 확인해주세요')"); 
				out.print("</script>");
		out.print("<script>");
			out.print("location.href='Ex02_JDBC_Login.jsp'");
		out.print("</script>");
		
		//
	}catch(Exception e){
		System.out.println(e.getMessage());
	}finally{
		Singleton_Helper.close(rs);
		Singleton_Helper.close(pstmt);
	} 
%>
