import os
import sys

def process_data():
    # Line 7: Safe default input (Source)
    user_command = "echo 'hello'"

    # ... untouched lines ...

    # Line 15: Command Injection (Sink)
    os.system("ls -la " + user_command)

if __name__ == "__main__":
    process_data()
