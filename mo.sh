#ffmpeg -loglevel debug -threads:v 2 -threads:a 8 -filter_threads 2 -thread_queue_size 512  -f dshow -i video="HP Wide Vision HD" -f dshow -i audio="Microphone Array (Realtek Audio)" -pix_fmt yuv420p -c:v libx264 -qp:v 19 -profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60 -g:v 120 -bf:v 3 -refs:v 16 -f flv rtmp://youtube_stream_url/stream_key
# -f v4l2 /dev/video10 \

# ffmpeg -i /dev/video0 -pix_fmt yuv420p \
#     -x264-params keyint=48:min-keyint=48:scenecut=-1 \
#     -b:v 4500k \
#     -b:a 128k \
#     -ar 44100 \
#     -acodec aac \
#     -vcodec libx264 \
#     -preset medium \
#     -crf 28 \
#     -threads 4 \


VBR="2500k"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

SOURCE="/dev/video0"              # Source UDP (voir les annonces SAP)
# SOURCE="vcam_videos/1.mp4"              # Source UDP (voir les annonces SAP)
KEY="b8dv-ssdx-803p-u2r8-6jfw"                                     # Clé à récupérer sur l'event youtube

# ffmpeg \
#     -i "$SOURCE" -deinterlace \
#     -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
#     -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
#     -f flv "$YOUTUBE_URL/$KEY"

#-c:v libx264 -b:v 2M -c:a copy -strict -2 -flags +global_header -bsf:a aac_adtstoasc -bufsize 2100k -f flv \

# //ffmpeg -re -f v4l2 -i $SOURCE -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/b8dv-ssdx-803p-u2r8-6jfw
ffmpeg -re -f v4l2 -i /dev/video2 \
    -c:v libx264 -preset veryfast -maxrate 3000k \
    -bufsize 6000k -pix_fmt yuv420p -g 50 -an \
    -f flv rtmp://a.rtmp.youtube.com/live2/b8dv-ssdx-803p-u2r8-6jfw
