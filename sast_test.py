import os
import sys

def process_data():
    # Line 6: Source (Where data enters)
    user_command = "echo 'hello'"

    print("Processing input...")
    print("Checking permissions...")
    print("Executing system task...")

    # Line 13: Sink (Where command executes)
    os.system("ls -la " + user_command)

if __name__ == "__main__":
    process_data()
