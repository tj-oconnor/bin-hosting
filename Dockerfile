FROM amd64/ubuntu:latest

run apt-get -qq update && apt-get install -qq xinetd build-essential wget make patchelf

RUN wget -O /bin/pwninit https://github.com/io12/pwninit/releases/download/3.2.0/pwninit && \
    chmod +x /bin/pwninit 

copy service.conf /service.conf
copy wrapper /wrapper
copy banner_fail /

copy chal.bin /chal
run chmod 755 /chal
copy flag.txt /
run chmod 644 /flag.txt

EXPOSE 31337/TCP

cmd ["/usr/sbin/xinetd", "-filelog", "-", "-dontfork", "-f", "/service.conf"]
