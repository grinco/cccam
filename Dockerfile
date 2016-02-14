FROM centos

WORKDIR /
# Install strace
RUN yum -y upgrade && yum -y install strace glibc.i686 libstdc++.i686 ilibgcc.i686 

# Bundle keys directory
COPY /var/ /opt/cccam/var/
RUN ln -s /opt/cccam/var/keys/ /var/keys

# copy etc and make all links
COPY /etc/ /opt/cccam/etc/
RUN cd /opt/cccam/etc && for i in *; do ln -fs /opt/cccam/etc/$i /etc/$i; done

# copy cccam binaries
COPY /bin/CCccam* /bin/
RUN chmod a+x /bin/CCcam*

# link the keys into the USR directory
RUN ln -s /var/keys/ /usr/keys

# run sanity checks
RUN ls -liah /bin/CCcam* /etc/CCcam.* /var/keys /usr/keys

EXPOSE 8888
EXPOSE 12000
VOLUME /opt/cccam

CMD [ "/bin/CCcam", "-d", "-c", "/etc/CCcam.cfg" ]

