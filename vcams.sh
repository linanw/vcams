
set -x

MAX_CAM=8
VIDEO_FOLDER="vcam_videos/"
LOG_FOLDER="vcam_logs/"

sudo modprobe v4l2loopback -r
sudo modprobe v4l2loopback device=$MAX_CAM video_nr=10,11,12,13,14,15,16,17

cam_amount=$MAX_CAM

if [ ! -z "$1" ] ; then
    re='^[0-9]+$'
    if [[ $1 =~ $re ]] ; then
        [ "$MAX_CAM" -gt "$1"  ] && cam_amount=$1
        [[ $2 == *"flip"* ]] && filter="-vf hflip"
    else
        [[ $1 == *"flip"* ]] && filter="-vf hflip"
    fi
fi

vidoe_folder=""
[ -d $VIDEO_FOLDER ] && vidoe_folder=$VIDEO_FOLDER
[ ! -d $LOG_FOLDER ] && mkdir -p $LOG_FOLDER

for i in $(seq 0 $((cam_amount-1)))
do 
    echo "${LOG_FOLDER}vcam_${i}".log
    nohup ffmpeg -stream_loop -1 -re -i $vidoe_folder$i.mp4 $filter -pix_fmt yuv420p -f v4l2 /dev/video1$i &> "${LOG_FOLDER}vcam_${i}".log &
done 
