import cv2

def main():
    gst_str = "v4l2src device=/dev/video0 ! video/x-raw,width=1280,height=720 ! videoconvert ! appsink"
    cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

    if not cap.isOpened():
        print("웹캠을 열 수 없음")
        return

    while True:
        ret, frame = cap.read()

        if not ret:
            break

        cv2.imshow('Webcam', frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
