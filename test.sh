FILE=short.mp4
VP9_DASH_PARAMS="-tile-columns 4 -frame-parallel 1"

ffmpeg -i ${FILE} \
  -c:v libvpx-vp9 -s 160x90 -b:v 250k -keyint_min 150 -g 150                  \
  ${VP9_DASH_PARAMS} -an -f webm -dash 1 video_160x90_250k.webm

ffmpeg -i ${FILE} -c:v libvpx-vp9 -s 320x180 -b:v 500k -keyint_min 150 -g 150 ${VP9_DASH_PARAMS} -an -f webm -dash 1 video_320x180_500k.webm

ffmpeg -i ${FILE} -c:v libvpx-vp9 -s 640x360 -b:v 750k -keyint_min 150 -g 150 ${VP9_DASH_PARAMS} -an -f webm -dash 1 video_640x360_750k.webm

ffmpeg -i ${FILE} -c:v libvpx-vp9 -s 640x360 -b:v 1000k -keyint_min 150 -g 150 ${VP9_DASH_PARAMS} -an -f webm -dash 1 video_640x360_1000k.webm

ffmpeg -i ${FILE} -c:v libvpx-vp9 -s 1280x720 -b:v 1500k -keyint_min 150 -g 150 ${VP9_DASH_PARAMS} -an -f webm -dash 1 video_1280x720_500k.webm

ffmpeg -i ${FILE} -c:a libvorbis -b:a 128k -vn -f webm -dash 1 audio_128k.webm

ffmpeg \
  -f webm_dash_manifest -i video_160x90_250k.webm \
  -f webm_dash_manifest -i video_320x180_500k.webm \
  -f webm_dash_manifest -i video_640x360_750k.webm \
  -f webm_dash_manifest -i video_640x360_1000k.webm \
  -f webm_dash_manifest -i video_1280x720_500k.webm \
  -f webm_dash_manifest -i audio_128k.webm \
  -c copy -map 0 -map 1 -map 2 -map 3 -map 4 -map 5 \
  -f webm_dash_manifest \
  -adaptation_sets "id=0,streams=0,1,2,3,4 id=1,streams=5" \
  manifest.mpd

