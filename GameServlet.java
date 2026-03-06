package com.mathsninja;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/game")
public class GameServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String mode = req.getParameter("mode");
        if (mode == null) mode = "add";

        // Handle Score Logic
        int score = (session.getAttribute("score") == null) ? 0 : (int) session.getAttribute("score");
        if ("true".equals(req.getParameter("correct"))) {
            score++;
        } else if ("true".equals(req.getParameter("reset"))) {
            score = 0;
        }
        session.setAttribute("score", score);

        // Generate Numbers
        Random r = new Random();
        int a = r.nextInt(10) + 1;
        int b = r.nextInt(10) + 1;
        int ans = 0;
        String symbol = "+";

        if (mode.equals("sub")) {
            if (a < b) { int t = a; a = b; b = t; } // Keep positive
            ans = a - b; symbol = "-";
        } else if (mode.equals("mul")) {
            ans = a * b; symbol = "×";
        } else {
            ans = a + b; symbol = "+";
        }

        req.setAttribute("a", a);
        req.setAttribute("b", b);
        req.setAttribute("ans", ans);
        req.setAttribute("symbol", symbol);
        req.setAttribute("mode", mode);

        req.getRequestDispatcher("game.jsp").forward(req, res);
    }
}