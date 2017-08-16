FROM registry.eorlbruder.de/supervisord
MAINTAINER David Magnus Henriques <eorlbruder@magnus-henriques.de>

RUN pacman -Syyu --noconfirm --noprogressbar mpd && \
    pacman -Sc --noconfirm

RUN touch /mnt/mpd.conf
RUN rm /etc/mpd.conf
RUN ln -s /mnt/mpd.conf /etc/mpd.conf

ADD assets/start.sh /start.sh
ADD assets/mpd-supervisor.conf /etc/supervisor/conf.d/mpd.conf

VOLUME /var/lib/mpd/music
VOLUME /var/lib/mpd/playlists

RUN chown -R mpd /var/lib/mpd

EXPOSE 6600
CMD ["supervisord", "-n"]
