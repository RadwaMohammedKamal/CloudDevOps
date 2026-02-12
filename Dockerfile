FROM python:3.9-slim

WORKDIR /app

# Create a stylish web page
RUN echo '\
from http.server import HTTPServer, BaseHTTPRequestHandler\n\
\n\
HTML_CONTENT = """<!DOCTYPE html>\n\
<html lang="en">\n\
<head>\n\
    <meta charset="UTF-8">\n\
    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n\
    <title>bahi devops</title>\n\
    <style>\n\
        * { margin: 0; padding: 0; box-sizing: border-box; }\n\
        body {\n\
            font-family: \"Inter\", -apple-system, BlinkMacSystemFont, \"Segoe UI\", sans-serif;\n\
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);\n\
            min-height: 100vh;\n\
            display: flex;\n\
            justify-content: center;\n\
            align-items: center;\n\
            overflow: hidden;\n\
        }\n\
        .container {\n\
            background: rgba(255, 255, 255, 0.1);\n\
            backdrop-filter: blur(10px);\n\
            border-radius: 30px;\n\
            padding: 60px 80px;\n\
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);\n\
            border: 1px solid rgba(255, 255, 255, 0.18);\n\
            text-align: center;\n\
            max-width: 600px;\n\
            animation: fadeIn 1s ease-in;\n\
        }\n\
        @keyframes fadeIn {\n\
            from { opacity: 0; transform: translateY(20px); }\n\
            to { opacity: 1; transform: translateY(0); }\n\
        }\n\
        h1 {\n\
            color: #ffffff;\n\
            font-size: 3rem;\n\
            font-weight: 700;\n\
            margin-bottom: 20px;\n\
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);\n\
        }\n\
        .emoji {\n\
            font-size: 4rem;\n\
            margin-bottom: 30px;\n\
            display: inline-block;\n\
            animation: bounce 2s infinite;\n\
        }\n\
        @keyframes bounce {\n\
            0%, 100% { transform: translateY(0); }\n\
            50% { transform: translateY(-20px); }\n\
        }\n\
        p {\n\
            color: rgba(255, 255, 255, 0.9);\n\
            font-size: 1.3rem;\n\
            line-height: 1.8;\n\
            margin-bottom: 30px;\n\
        }\n\
        .badge {\n\
            display: inline-block;\n\
            background: rgba(255, 255, 255, 0.2);\n\
            padding: 12px 24px;\n\
            border-radius: 50px;\n\
            color: #fff;\n\
            font-weight: 600;\n\
            font-size: 0.9rem;\n\
            margin-top: 20px;\n\
            border: 1px solid rgba(255, 255, 255, 0.3);\n\
        }\n\
        .status {\n\
            margin-top: 30px;\n\
            display: flex;\n\
            justify-content: center;\n\
            gap: 15px;\n\
        }\n\
        .status-item {\n\
            background: rgba(34, 197, 94, 0.2);\n\
            padding: 10px 20px;\n\
            border-radius: 20px;\n\
            color: #fff;\n\
            font-size: 0.85rem;\n\
            border: 1px solid rgba(34, 197, 94, 0.4);\n\
        }\n\
        .pulse {\n\
            width: 8px;\n\
            height: 8px;\n\
            background: #22c55e;\n\
            border-radius: 50%;\n\
            display: inline-block;\n\
            margin-right: 8px;\n\
            animation: pulse 2s infinite;\n\
        }\n\
        @keyframes pulse {\n\
            0%, 100% { opacity: 1; }\n\
            50% { opacity: 0.5; }\n\
        }\n\
    </style>\n\
</head>\n\
<body>\n\
    <div class="container">\n\
        <div class="emoji">🚀</div>\n\
        <h1>DevOps bahi</h1>\n\
        <p>Your infrastructure is <strong>live</strong> and running smoothly!</p>\n\
        <div class="badge">✨ Powered by Kubernetes & Docker</div>\n\
        <div class="status">\n\
            <div class="status-item">\n\
                <span class="pulse"></span>Container Running (bahi)\n\
            </div>\n\
            <div class="status-item">\n\
                <span class="pulse"></span>All Systems(bahi)\n\
            </div>\n\
        </div>\n\
    </div>\n\
</body>\n\
</html>"""\n\
\n\
class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):\n\
    def do_GET(self):\n\
        self.send_response(200)\n\
        self.send_header("Content-type", "text/html")\n\
        self.end_headers()\n\
        self.wfile.write(HTML_CONTENT.encode())\n\
\n\
httpd = HTTPServer(("0.0.0.0", 8080), SimpleHTTPRequestHandler)\n\
httpd.serve_forever()\n\
' > app.py

EXPOSE 8080

CMD ["python", "app.py"]