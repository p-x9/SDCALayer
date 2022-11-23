import asyncio
import websockets
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer
import sys
import os

ip_adress = "0.0.0.0"
port = 8765

file_path = ""
is_update_required = True

class WatchdogHandler(FileSystemEventHandler):
    def __init__(self, callback):
        super().__init__()
        self.callback = callback

    def __callback_handler(self, func, *args):
        return func(*args)

    def on_modified(self, event):
        print(event)
        self.__callback_handler(self.callback)

def callback():
    global is_update_required
    is_update_required = True

async def handler(websocket, path):
    print("connected", path, websocket)

    observer = Observer()
    event_handler = WatchdogHandler(callback=callback)
    observer.schedule(event_handler, file_path, recursive=True)
    observer.start()

    try:
        async for message in websocket:
            global is_update_required
            print(message)
            if is_update_required:
                f = open(file_path, 'r')
                message = f.read()
                f.close()
                await websocket.send(message)
                is_update_required = False
    except:
        observer.stop()
        observer.join()
        is_update_required = True
        print("stop")

async def main():
    async with websockets.serve(handler, ip_adress, port):
        await asyncio.Future()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("invalid argments")
        exit(1)
    
    file_path = sys.argv[1]

    if not os.path.isfile(file_path):
        print("invalid file path")
        exit(1)
    
    asyncio.run(main())