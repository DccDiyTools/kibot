#!/bin/sh

if [ ! -d .kibot ]; then
  git clone https://github.com/DccDiyTools/kibot.git .kibot
else
  git -C .kibot pull
fi

LOCAL_LIBS=""
if [ -d /Applications/KiCad/KiCad.app/Contents/SharedSupport ]; then
  LOCAL_LIBS="-v /Applications/KiCad/KiCad.app/Contents/SharedSupport:/usr/share/kicad/"
fi

docker run -it --rm \
  -v $(pwd):/work \
  -v $(pwd)/.kibot:/opt/kibot \
  $LOCAL_LIBS \
  -w /work \
  -e KIBOT_ROOT_SCRIPTS=/opt/kibot/kibot \
  ghcr.io/inti-cmnb/kicad8_auto_full:latest 