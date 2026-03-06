<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    // Get data from Servlet
    Integer a = (Integer) request.getAttribute("a");
    Integer b = (Integer) request.getAttribute("b");
    Integer correctAns = (Integer) request.getAttribute("ans");
    String symbol = (String) request.getAttribute("symbol");
    String mode = (String) request.getAttribute("mode");
    
    String user = (String) session.getAttribute("username");
    if(user == null) user = "Player";
    
    Integer score = (Integer) session.getAttribute("score");
    if(score == null) score = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Maths Ninja</title>
    <style>
        body { font-family: 'Segoe UI', Arial; text-align: center; background: linear-gradient(to top, #8ec5fc, #e0c3fc); margin: 0; height: 100vh; overflow: hidden; }
        h2 { font-size: 3rem; margin-top: 50px; }
        .circle { display: inline-block; width: 80px; height: 80px; line-height: 80px; border-radius: 50%; background: #ff9800; color: white; font-size: 1.5rem; margin: 15px; cursor: pointer; transition: 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
        .circle:hover { transform: scale(1.2); background: #e68900; }
        #timer, #score { font-size: 1.5rem; font-weight: bold; }
        #message { font-size: 1.5rem; height: 30px; margin-top: 20px; font-weight: bold; }

        /* Confetti Styles */
        .confetti {
            position: absolute; width: 10px; height: 10px; z-index: 999;
            animation: fall 3s linear forwards;
        }
        @keyframes fall {
            to { transform: translateY(100vh) rotate(720deg); }
        }
    </style>
</head>
<body>

    <div id="score">Score: <span id="score-val"><%= score %></span></div>
    <div id="timer">Time: 15</div>
    
    <h2 id="q-text"><%= a %> <%= symbol %> <%= b %> = ?</h2>
    
    <div id="options">
        </div>

    <div id="message"></div>

    <script>
        const correctAns = <%= correctAns %>;
        const username = "<%= user %>";
        let timeLeft = 15;

        // 1. Generate 2 wrong answers near the correct one
        function getOptions() {
            let opts = [correctAns];
            while(opts.length < 3) {
                let offset = Math.floor(Math.random() * 5) + 1;
                let wrong = Math.random() > 0.5 ? correctAns + offset : correctAns - offset;
                if(!opts.includes(wrong)) opts.push(wrong);
            }
            return opts.sort(() => Math.random() - 0.5);
        }

        // 2. Render Buttons
        const optionsDiv = document.getElementById("options");
        getOptions().forEach(val => {
            let btn = document.createElement("div");
            btn.className = "circle";
            btn.innerText = val;
            btn.onclick = () => check(val);
            optionsDiv.appendChild(btn);
        });

        // 3. Timer Logic
        const timerLabel = document.getElementById("timer");
        const interval = setInterval(() => {
            timeLeft--;
            timerLabel.innerText = "Time: " + timeLeft;
            if(timeLeft <= 0) {
                clearInterval(interval);
                fail("Time Up!");
            }
        }, 1000);

        function check(selected) {
            if(selected === correctAns) {
                success();
            } else {
                fail("Wrong Answer!");
            }
        }

        function success() {
            clearInterval(interval);
            document.getElementById("message").style.color = "green";
            document.getElementById("message").innerText = "🎉 Good Job, " + username + "!";
            createConfetti();
            // Wait then reload to get next question from Servlet
            setTimeout(() => {
                window.location.href = "game?mode=<%= mode %>&correct=true";
            }, 1500);
        }

        function fail(msg) {
            clearInterval(interval);
            document.getElementById("message").style.color = "red";
            document.getElementById("message").innerText = msg + " Try Again!";
            setTimeout(() => {
                window.location.href = "game?mode=<%= mode %>&reset=true";
            }, 1500);
        }

        function createConfetti() {
            for(let i=0; i<50; i++) {
                let c = document.createElement("div");
                c.className = "confetti";
                c.style.left = Math.random() * 100 + "vw";
                c.style.backgroundColor = "hsl(" + (Math.random()*360) + ", 100%, 50%)";
                c.style.top = "-10px";
                document.body.appendChild(c);
            }
        }
    </script>
    <div style="margin-top: 30px;">
    <button class="back-btn" onclick="goToSelect()">← Back to Menu</button>
</div>

<script>
    function goToSelect() {
        // This will redirect the user to your selection page
        window.location.href = "select.jsp";
    }
</script>
</body>
</html>