## 911builder

### Wat iz dis ?

911 builder creates an initramfs that can bue used with the same kernel as is running on this machine that:
  - runs a complete ubuntu in memory
  - can be booted from pxe
  - can use `apt update`, `apt install`
  - can mount local filesystems, md devices, run filesystem checks, make images...

### How?

  1. Prepare a vm or a docker with ubuntu >= 16.04
  1. Work as a user, be able to do `sudo`
  1. Install `build-essential` and `debootstrap`
  1. Install the latest and greatest kernel for your machine
  1. Delete the `./root` dir if you start from scratch
  1. Basically: just run `./prepareroot`

That'll create a `ramfs` file.

### Showtime! (on an ubuntu 16.04 VM)

```
sudo apt update
sudo apt install build-essential debootstrap ipmitool syslinux genisoimage pigz

# get the builder (is also a submodule in https://github.com/0-complexity/G8OS_boot)
git clone git@github.com/0-complexity/911builder.git

cd 911builder
# remove ./root when it's your first time
# that way, a debootstrap populates a new tree
rm -rf ./root ./binaries/* GIGINSTALLER.iso

# run it
./prepareroot

# debootstrap gets run
# other necessary packages from "pkglist" get installed
# when finished , you'll find a file "ramfs" -> that is the initrd

ls binaries
ls -lh GIGINSTALLER.iso

```

That'll create a `ramfs` file. Together with the __running__ kernel of your host,
you can boot it as

  - snippet of vm's xml for booting it

```xml
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.11'>hvm</type>
    <kernel>/boot/vmlinuz</kernel>
    <initrd>/boot/ramfs</initrd>
    <boot dev='hd'/>
  </os>
```

in qemu

or configure pxe to use these files for `linux` and `initrd`

or whatevvah

Otherwise, you can boot from CDROM on a VM with GIGINSTALLER.iso,

Or `dd if=GIGINSTALLER.iso of=${yourUSBdrive} bs=1M conv=fdatasync oflag=dsync`

and boot it from USB

## NOW:

### Build it with Docker

I assume you (by now) know how to install/use docker, so that will not be handeled here.

Simple:

```
# create your work image
docker build -t 911builder:latest .

That builds a woking environment, where you can:

docker run --privileged --rm -v $(pwd)/binaries:/binaries 911builder:latest

# in that environment you can `cd /911builder ; ./prepareroot`

# Or re-enter the env with `./runenv.sh`

```

Then, in `./binaries` you'll find `vmlinuz` and `ramfs` that you can use for pxeboot
and also `./GIGINSTALLER.iso` to boot a testvm from, or write it to an usb


### Or, Of course,

you can just build it with

```sh
./buildfromscratch
```

that just does all of the above ;-)


