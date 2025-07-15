FROM debian:stable-slim

RUN apt update

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y unzip wget xfce4 xrdp supervisor dbus-x11 openjdk-17-jdk libwebkit2gtk-4.0-dev

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt update
RUN apt install -y google-chrome-stable
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

ARG DEFAULT_PWD=rytass

RUN useradd -m -s /bin/bash rytass
RUN echo "rytass:$DEFAULT_PWD" | chpasswd

RUN echo "startxfce4" > /home/rytass/.xsession
RUN chown rytass:rytass /home/rytass/.xsession

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY driver /home/rytass/freego
COPY Freego.desktop /home/rytass/Desktop/Freego.desktop

RUN chmod +x /home/rytass/Desktop/Freego.desktop

RUN wget "https://storage.googleapis.com/chrome-for-testing-public/$(google-chrome --version | awk '{print $3}')/linux64/chromedriver-linux64.zip" -O /tmp/chromedriver-linux64.zip
RUN unzip /tmp/chromedriver-linux64.zip -d /home/rytass
RUN mv /home/rytass/chromedriver-linux64/chromedriver /home/rytass/freego/chromedriver
RUN rm -rf /home/rytass/chromedriver-linux64/

EXPOSE 3389

CMD ["/usr/bin/supervisord", "-n"]
