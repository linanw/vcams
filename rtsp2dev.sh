
set -x

MAX_CAM=1
VIDEO_FOLDER="vcam_videos/"
LOG_FOLDER="vcam_logs/"

sudo modprobe v4l2loopback -r
sudo modprobe v4l2loopback device=$MAX_CAM video_nr=20

cam_amount=$MAX_CAM

vidoe_folder=""
[ -d $VIDEO_FOLDER ] && vidoe_folder=$VIDEO_FOLDER
[ ! -d $LOG_FOLDER ] && mkdir -p $LOG_FOLDER

for i in $(seq 0 $((cam_amount-1)))
do 
    echo "${LOG_FOLDER}vcam_${i}".log
    nohup ffmpeg -1 -re -i rtsp://zoom:stream-rtsp@192.168.72.171 -pix_fmt yuv420p -f v4l2 /dev/video20 &> "${LOG_FOLDER}vcam_${i}".log &
done 
