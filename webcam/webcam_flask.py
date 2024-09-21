import cv2
import threading
import queue
import requests
import base64

def capture_frames(cap, frame_queue):
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        if not frame_queue.full():
            frame_queue.put(frame)

def send_frame(frame):
    _, buffer = cv2.imencode('.jpg', frame)
    jpg_as_text = base64.b64encode(buffer).decode('utf-8')
    try:
        response = requests.post('http://210.123.37.75:5000/receive_frame', json={'frame': jpg_as_text})
        print(f"Frame sent. Response: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Error sending frame: {e}")

def main():
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
    cap.set(cv2.CAP_PROP_FPS, 30)

    if not cap.isOpened():
        print("웹캠을 열 수 없음")
        return

    frame_queue = queue.Queue(maxsize=10)
    capture_thread = threading.Thread(target=capture_frames, args=(cap, frame_queue))
    capture_thread.start()

    while True:
        if not frame_queue.empty():
            frame = frame_queue.get()
            cv2.imshow('Webcam', frame)
            send_frame(frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
    capture_thread.join()

if __name__ == "__main__":
    main()
