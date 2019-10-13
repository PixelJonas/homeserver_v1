ROOT_DIR="/media/server"

CONF_DIR="$ROOT_DIR/config"
MEDIA_DIR="$ROOT_DIR/media"

DOWNLOAD_DIR="$MEDIA_DIR/downloads"
MOVIE_DIR="$MEDIA_DIR/movies"
TVSHOW_DIR="$MEDIA_DIR/tvshows"
TRANSCODING_DIR="$MEDIA_DIR/transcoding"

# Add groups and users
groupadd -K GID_MIN=100 -K GID_MAX=499 media

useradd -r -s /bin/false -G media couchpotato
useradd -r -s /bin/false -G media sonarr
useradd -r -s /bin/false -G media plex
useradd -r -s /bin/false -G media sabnzbd
useradd -r -s /bin/false -G media openvpn

# Create directories and change ownership
mkdir -p $CONF_DIR $MEDIA_DIR $DOWNLOAD_DIR $MOVIE_DIR $TVSHOW_DIR $TRANSCODING_DIR "$ROOT_DIR/incomplete"

chmod 775 $MOVIE_DIR
chown couchpotato:media $MOVIE_DIR

chmod 775 $TVSHOW_DIR
chown sonarr:media $TVSHOW_DIR

chmod 775 $DOWNLOAD_DIR
chown sabnzbd:media $DOWNLOAD_DIR
chown sabnzbd:media $ROOT_DIR/incomplete

chmod 775 $TRANSCODING_DIR
chown plex:media $TRANSCODING_DIR

apps=( plex sonarr couchpotato sabnzbd openvpn )
for app in "${apps[@]}"
do
  mkdir -p "$CONF_DIR"/"$app"
  chown "$app":"$app" "$CONF_DIR"/"$app"
done



#============  PLEX ========
#echo "Creating plex docker container..."
#MY_UID=$(id -u plex)
#MY_GID=$(getent group media | awk -F: '{print $3}')

#docker create \
#   --name=plex \
#    --net=host \
#    -e VERSION=latest \
#    -e PUID=$MY_UID -e PGID=$MY_GID \
#    -v $CONF_DIR/plex:/config \
#    -v $TVSHOW_DIR:/data/tvshows \
#    -v $MOVIE_DIR:/data/movies \
#    linuxserver/plex

#======== NZBGET ========
# echo "Creating nzbget docker container..."
# MY_UID=$(id -u nzbget)
# MY_GID=$(getent group media | awk -F: '{print $3}')
#
# docker create \
#     --name nzbget \
#     -p 6789:6789 \
#     -e PUID=$MY_UID -e PGID=$MY_GID \
#     -v $CONF_DIR/nzbget:/config \
#     -v $DOWNLOAD_DIR:/downloads \
#     linuxserver/nzbget

#======== SONARR ========
#echo "Creating sonarr docker container..."
#MY_UID=$(id -u sonarr)
#MY_GID=$(getent group media | awk -F: '{print $3}')

#docker create \
#    --name sonarr \
#    -p 8989:8989 \
#    -e PUID=$MY_UID -e PGID=$MY_GID \
#    -v /dev/rtc:/dev/rtc:ro \
#    -v $CONF_DIR/sonarr:/config \
#    -v $TVSHOW_DIR:/tv \
#    -v $DOWNLOAD_DIR:/downloads \
#    linuxserver/sonarr

#======== COUCHPOTATO ========
#echo "Creating couchpotato docker container..."
#MY_UID=$(id -u couchpotato)
#MY_GID=$(getent group media | awk -F: '{print $3}')

#docker create \
#    --name=couchpotato \
#    -p 5050:5050 \
#    -e PUID=$MY_UID -e PGID=$MY_GID \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v $CONF_DIR/couchpotato:/config \
#    -v $MOVIE_DIR:/movies \
#    -v $DOWNLOAD_DIR:/downloads \
#    linuxserver/couchpotato
#
#==========SABNZBD===========

#MY_UID=$(id -u sabnzbd)
#MY_GID=$(getent group media | awk -F: '{print $3}')


#docker create --name=sabnzbd \
#-v $CONF_DIR/sabnzbd:/config \
#-v $DOWNLOAD_DIR:/downloads \
#-v $ROOT_DIR/incomplete:/incomplete-downloads \
#-v /etc/localtime:/etc/localtime:ro \
#-e PGID=$MY_GID -e PUID=$MY_UID \
#-p 8080:8080 -p 9090:9090 linuxserver/sabnzbd
#

#echo "Restarting all apps, this may take a while..."
#docker restart plex sabnzbd sonarr couchpotato openhab