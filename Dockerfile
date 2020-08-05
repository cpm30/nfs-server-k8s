FROM centos:7.8.2003

LABEL Chris Montague <cmontague@databank.com>

ENV container=docker

RUN rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y --setopt=tsflags=nodocs install nfs-utils && \
    mkdir -p /exports && \
    yum clean all
COPY run-mountd.sh /

VOLUME ["/exports"]
EXPOSE 111/udp 2049/tcp

ENTRYPOINT ["/run-mountd.sh"]
