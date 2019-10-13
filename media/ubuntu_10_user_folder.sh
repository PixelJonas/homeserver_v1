ROOT_DIR="/media/server"

CONF_DIR="$ROOT_DIR/config"
MEDIA_DIR="$ROOT_DIR/media"

DOWNLOAD_DIR="$MEDIA_DIR/downloads"
MOVIE_DIR="$MEDIA_DIR/movies"
TVSHOW_DIR="$MEDIA_DIR/tvshows"
TRANSCODING_DIR="$MEDIA_DIR/transcoding"

# Add groups and users
groupadd -K GID_MIN=100 -K GID_MAX=499 media

useradd -r -s /bin/false -G media radarr
useradd -r -s /bin/false -G media sonarr
useradd -r -s /bin/false -G media plex
useradd -r -s /bin/false -G media sabnzbd
useradd -r -s /bin/false -G media openvpn
useradd -r -s /bin/false -G media tautulli
useradd -r -s /bin/false -G media heimdall

# Create directories and change ownership
mkdir -p $CONF_DIR $MEDIA_DIR $DOWNLOAD_DIR $MOVIE_DIR $TVSHOW_DIR $TRANSCODING_DIR "$ROOT_DIR/incomplete"

chmod 775 $MOVIE_DIR
chown radarr:media $MOVIE_DIR

chmod 775 $TVSHOW_DIR
chown sonarr:media $TVSHOW_DIR

chmod 775 $DOWNLOAD_DIR
chown sabnzbd:media $DOWNLOAD_DIR
chown sabnzbd:media $ROOT_DIR/incomplete

chmod 775 $TRANSCODING_DIR
chown plex:media $TRANSCODING_DIR

apps=( plex sonarr radarr sabnzbd openvpn tautulli heimdall )
for app in "${apps[@]}"
do
  mkdir -p "$CONF_DIR"/"$app"
  chown "$app":"$app" "$CONF_DIR"/"$app"
done
