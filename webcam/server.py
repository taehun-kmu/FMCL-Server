# server.py
import asyncio
import cv2
import numpy as np
from fastapi import FastAPI, WebSocket
from fastapi import WebSocketDisconnect
from fastapi import Depends
from threading import Thread

app = FastAPI()

# 전역 변수로 프레임을 저장할 변수 설정
latest_frame = None


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    global latest_frame
    await websocket.accept()
    try:
        while True:
            # 클라이언트로부터 바이너리 데이터 수신
            data = await websocket.receive_bytes()
            # 프레임 디코딩
            np_data = np.frombuffer(data, np.uint8)
            frame = cv2.imdecode(np_data, cv2.IMREAD_COLOR)
            if frame is not None:
                latest_frame = frame
    except WebSocketDisconnect:
        print("Client disconnected")


def display_frames():
    global latest_frame
    while True:
        if latest_frame is not None:
            cv2.imshow("Received Video", latest_frame)
            if cv2.waitKey(1) & 0xFF == ord("q"):
                break
    cv2.destroyAllWindows()


if __name__ == "__main__":
    # 디스플레이 쓰레드 시작
    display_thread = Thread(target=display_frames)
    display_thread.start()
    # FastAPI 서버 실행
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
