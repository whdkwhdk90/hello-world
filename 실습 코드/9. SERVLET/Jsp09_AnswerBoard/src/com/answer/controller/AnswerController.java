package com.answer.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.answer.dao.AnswerDao;
import com.answer.dto.AnswerDto;

@WebServlet("/answer.do")
public class AnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AnswerController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.printf("{%s}\n",command);
		
		AnswerDao dao = new AnswerDao();
		
		if(command.equals("list")) {
			List<AnswerDto> list  = dao.selectAll(); 
			
			request.setAttribute("list", list);
			dispatch("boardlist.jsp",request,response);
			
		}else if(command.equals("writeform")) {
			
			response.sendRedirect("boardwrite.jsp");
			
		}else if(command.equals("boardwrite")) {
			
			String title = request.getParameter("title");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			
			AnswerDto dto = new AnswerDto(writer,title,content);
			
			int res = dao.insert(dto);
			
			if(res>0) {
				dispatch("answer.do?command=list",request,response);
			}else {
				dispatch("answer.do?command=writeform",request,response);
			}
		}else if(command.equals("detail")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			
			AnswerDto dto = dao.selectOne(boardno);
			
			request.setAttribute("dto", dto);
			dispatch("boarddetail.jsp",request,response);
			
		}else if(command.equals("answerform")) {
			
			int parentboardno = Integer.parseInt(request.getParameter("parentboardno"));
			
			AnswerDto dto = dao.selectOne(parentboardno);
			request.setAttribute("parent", dto);
			dispatch("answerwrite.jsp",request,response);
			
			
		}else if(command.equals("answerwrite")) {
			
			int parentboardno = Integer.parseInt(request.getParameter("parentboardno"));
			String title = request.getParameter("title");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			
			AnswerDto parent = dao.selectOne(parentboardno);
			
			//일단 3가지의 데이터 먼저 받아온다.
			int parentgroupno = parent.getGroupno();
			int parentgroupsq = parent.getGroupsq();
			int parenttitletab = parent.getTitletab();
			
			//1. update를 먼저 한다.
			int updateRes = dao.updateAnswer(parentgroupno,parentgroupsq);
			if(updateRes>0) {
				System.out.println("순서 변경 성공");
			}else {
				System.out.println("순서 변경 실패 or 변경 글 없음");
			}
			//2. insert 시킨다.
			AnswerDto dto = new AnswerDto(0,parentgroupno,parentgroupsq,parenttitletab,title,content,writer,null);
			
			int insertRes = dao.insertAnswer(dto);
			
			if(insertRes>0) {
				response.sendRedirect("answer.do?command=list");
			}else {
				response.sendRedirect("answer.do?command=detail&boardno="+parentboardno);
			}
			
		}
		
		
		
	}

	private void dispatch(String string, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(string);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
