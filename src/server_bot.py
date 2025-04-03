import os
import yaml
import paramiko
from flask import Flask, render_template
from flask_socketio import SocketIO
from dotenv import load_dotenv

class LinuxServerBot:
    def __init__(self):
        self.app = Flask(__name__)
        self.socketio = SocketIO(self.app)
        self.config = self.load_config()
        self.ssh_client = None
        self.setup_routes()

    def load_config(self):
        config_path = os.path.join(os.path.dirname(__file__), '../config/config.yaml')
        with open(config_path, 'r') as f:
            return yaml.safe_load(f)

    def setup_routes(self):
        @self.app.route('/')
        def index():
            return render_template('index.html')

        @self.socketio.on('connect')
        def handle_connect():
            print('Client connected')

        @self.socketio.on('disconnect')
        def handle_disconnect():
            print('Client disconnected')

    def setup_ssh(self):
        self.ssh_client = paramiko.SSHClient()
        self.ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            self.ssh_client.connect(
                'localhost',
                port=self.config['ssh']['port'],
                username=self.config['ssh']['username'],
                password=self.config['ssh']['password']
            )
            return True
        except Exception as e:
            print(f"SSH connection failed: {str(e)}")
            return False

    def setup_vnc(self):
        # Setup VNC server
        vnc_cmd = f"vncserver {self.config['vnc']['display']} -geometry 1920x1080"
        stdin, stdout, stderr = self.ssh_client.exec_command(vnc_cmd)
        return stdout.read().decode()

    def start(self):
        if self.setup_ssh():
            print("SSH connection established")
            vnc_output = self.setup_vnc()
            print(f"VNC server started: {vnc_output}")
            
            self.socketio.run(
                self.app,
                host=self.config['server']['host'],
                port=self.config['server']['port'],
                debug=self.config['server']['debug']
            )
        else:
            print("Failed to start server")

if __name__ == '__main__':
    load_dotenv()
    bot = LinuxServerBot()
    bot.start() 