<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            form {
                max-width: 400px;
                width: 100%;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
            }
            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type="submit"],
            input[type="reset"] {
                width: 100%;
                margin-bottom: 9px;
                padding: 10px;
                border: none;
                border-radius: 4px;
                background-color: #4caf50;
                color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            input[type="submit"]:hover,
            input[type="reset"]:hover {
                background-color: #45a049;
            }
            a {
                text-decoration: none;
                color: #4caf50;
                display: block;
                text-align: center;
                margin-top: 10px;
            }
            a:hover {
                text-decoration: underline;
            }
            #captchaContainer {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            #refresh {
                background-color: white;
                display: flex;
                align-items: center;
                cursor: pointer;
            }
            #refresh img {
                cursor: pointer;
            }
            #captchaInput {
                width: 150px;
                height: 40px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                margin-left: 10px;
                margin-top: 10px;
            }
            #captchaCanvas {           
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            #errorMessage {
            color: red;
            text-align: center;
            margin-bottom: 10px;
            font-size: 14px;
        }
        </style>
        <script type="text/javascript">
            window.addEventListener('load', function () {
                const canvas = document.getElementById('captchaCanvas');
                const ctx = canvas.getContext('2d');

                // Function to generate random characters
                function generateCaptcha() {
                    const chars = 'ABCDEFGHJKMNOPQRSTUVWXYZabcdefghjkmnopqrstuvwxyz0123456789';
                    let captchaText = '';
                    for (let i = 0; i < 6; i++) {
                        captchaText += chars.charAt(Math.floor(Math.random() * chars.length));
                    }
                    return captchaText;
                }

                // Function to draw the CAPTCHA text on canvas
                function drawCaptcha(captcha) {
                    ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas before drawing new CAPTCHA
                    ctx.font = '20px Arial';
                    ctx.fillStyle = 'black'; // Text color

                    // Calculate the width of the text
                    const textWidth = ctx.measureText(captcha).width;
                    const xPosition = (canvas.width - textWidth) / 2;
                    const yPosition = (canvas.height + 20) / 2; // Adjusting for the text height

                    ctx.fillText(captcha, xPosition, yPosition);

                    // Draw a line through the CAPTCHA text
                    ctx.strokeStyle = 'red'; // Line color
                    ctx.beginPath();
                    ctx.moveTo(0, canvas.height / 2);
                    ctx.lineTo(canvas.width, canvas.height / 2);
                    ctx.stroke();
                }

                // Generate initial CAPTCHA text
                let captcha = generateCaptcha();
                drawCaptcha(captcha);

                // Handle form submission and validate CAPTCHA
                const form = document.getElementById('Capcha'); // Replace with your form ID
                form.addEventListener('submit', function (event) {
                    const userCaptcha = document.getElementById('captchaInput').value;
                    if (userCaptcha.toLowerCase() !== captcha.toLowerCase()) {
                        alert('Invalid CAPTCHA!');
                        event.preventDefault(); // Prevent form submission
                        captcha = generateCaptcha(); // Generate new CAPTCHA
                        drawCaptcha(captcha); // Draw new CAPTCHA
                    }
                });

                // Handle CAPTCHA reload
                document.getElementById('refresh').addEventListener('click', function () {
                    captcha = generateCaptcha(); // Generate new CAPTCHA
                    drawCaptcha(captcha); // Draw new CAPTCHA
                });
            });
        </script>
    </head>
    <body>
        <form id="Capcha" action="MainController" method="POST">
            <h1>Login information</h1>
            <label for="userID">User ID:</label>
            <input type="text" id="userID" name="userID" required />
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />
            <div id="captchaContainer">
                <canvas id="captchaCanvas" width="150" height="40" style="background-color: #fff;"></canvas>
                <div id="refresh"><img src="https://www.svgrepo.com/show/165646/reload.svg" width="30px" height="30px"></div>
                <input id="captchaInput" type="text" name="captcha" placeholder="Enter CAPTCHA" required />
            </div>
            <div id="errorMessage">${requestScope.ERROR}</div>
            <input type="submit" name="action" value="Login" />
            <input type="reset" value="Reset" />
            <a href="MainController?action=Create_Page">Create User</a>
        </form>
    </body>
</html>
