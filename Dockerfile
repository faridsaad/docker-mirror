FROM rhel7:latest
USER root
ADD sync.sh /root/sync.sh
ADD images.list /root/images.list
RUN /usr/bin/chmod 755 /root/sync.sh
RUN yum --enablerepo=rhel-7-server-extras-rpms -y install skopeo
