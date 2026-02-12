from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cloud DevOps App</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .card {
                background: white;
                padding: 3rem;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                text-align: center;
                border-top: 8px solid #007bff;
                position: relative;
            }
            h1 { color: #333; margin-bottom: 1rem; }
            p { color: #666; font-size: 1.2rem; }
            .status {
                display: inline-block;
                padding: 5px 15px;
                background: #28a745;
                color: white;
                border-radius: 20px;
                font-size: 0.9rem;
                margin-top: 1rem;
            }
            .rocket { font-size: 3rem; }
            .footer {
                margin-top: 2rem;
                font-size: 0.8rem;
                color: #888;
                border-top: 1px solid #eee;
                padding-top: 1rem;
            }
            .name {
                color: #007bff;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <div class="rocket">🚀</div>
            <h1>Hello from EKS!</h1>
            <p>Your Cloud DevOps Pipeline is working perfectly.</p>
            <div class="status">Deployed via ArgoCD</div>
            
            <div class="footer">
                Developed by <span class="name">Radwa Mohamed Kamal</span>
            </div>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)


# from flask import Flask

# app = Flask(__name__)

# @app.route("/")
# def hello():
#     return """
#     <!DOCTYPE html>
#     <html lang="en">
#     <head>
#         <meta charset="UTF-8">
#         <meta name="viewport" content="width=device-width, initial-scale=1.0">
#         <title>Cloud DevOps App</title>
#         <style>
#             body {
#                 font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
#                 background-color: #f0f2f5;
#                 display: flex;
#                 justify-content: center;
#                 align-items: center;
#                 height: 100vh;
#                 margin: 0;
#             }
#             .card {
#                 background: white;
#                 padding: 3rem;
#                 border-radius: 15px;
#                 box-shadow: 0 10px 25px rgba(0,0,0,0.1);
#                 text-align: center;
#                 border-top: 8px solid #007bff;
#             }
#             h1 { color: #333; margin-bottom: 1rem; }
#             p { color: #666; font-size: 1.2rem; }
#             .status {
#                 display: inline-block;
#                 padding: 5px 15px;
#                 background: #28a745;
#                 color: white;
#                 border-radius: 20px;
#                 font-size: 0.9rem;
#                 margin-top: 1rem;
#             }
#             .rocket { font-size: 3rem; }
#         </style>
#     </head>
#     <body>
#         <div class="card">
#             <div class="rocket">🚀</div>
#             <h1>Hello from EKS!</h1>
#             <p>Your Cloud DevOps Pipeline is working perfectly.</p>
#             <div class="status">Deployed via ArgoCD</div>
#         </div>
#     </body>
#     </html>
#     """

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=8080)


# # from flask import Flask

# # app = Flask(__name__)

# # @app.route("/")
# # def hello():
# #     return "Hello from Kubernetes 🚀"

# # if __name__ == "__main__":
# #     app.run(host="0.0.0.0", port=8080)

