FROM ubuntu:latest

# necessary tools
RUN apt-get update ; \
    DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential debootstrap isolinux git

# get kernel in there
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install linux-headers-4.13.0-19-generic \
    linux-image-4.13.0-19-generic \
    linux-image-extra-4.13.0-19-generic \
    linux-tools-4.13.0-19-generic

# get some cdrom tools in place
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install genisoimage isolinux \
    syslinux
# some bins that copied into the initramfs
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install squashfs-tools ipmitool

# get myself (911builder) in the dock
# ADD . /911builder/

CMD bash -c 'cd /911builder ; ./prepareroot'

