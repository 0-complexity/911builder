FROM ubuntu:latest

# necessary tools
RUN apt-get update ; \
    DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential debootstrap git

# yea, I need some tools too, whe I do ./runenv
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim-nox pigz

# get kernel in there
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install linux-headers-4.13.0-19-generic \
    linux-image-4.13.0-31-generic \
    linux-image-extra-4.13.0-31-generic \
    linux-tools-4.13.0-31-generic


# get some cdrom tools in place
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install genisoimage isolinux \
    syslinux syslinux-utils
# some bins that get copied into the initramfs
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install squashfs-tools ipmitool

CMD bash -c "cd /911builder ; ./prepareroot"
# get myself (911builder) in the dock
# Nope : use `-v $(pwd)/ /911builder
# ADD . /911builder/


