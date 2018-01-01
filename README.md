## 911builder

### What is dis ?

911 builder creates an initramfs that can bue used with the same kernel as is running on this machine that:
  - runs a complete ubuntu in memory
  - can be booted from pxe
  - can use `apt update`, `atp install`
  - can mount local filesystems, md devices, run filesystem checks, make images...

### How?

  1. Prepare a vm (yes, a VM, as it't going to be difficult (for now) to get it all going in a docker) with ubuntu >= 16.04
  1. work as a user, be able to do `sudo`
  1. Install `build-essential` and `debootstrap`
  1. Install the latest & greatest kernel for your VM
  1. delete the `./root` dir if you start from scratch
  1. Basically : just run `./prepareroot`

That'll create a `ramfs` file. Together with the __running__ kernel of your host,
you can boot it as 

### Showtime!

```
sudo apt update
sudo apt install build-essential debootstrap
# latest & greatest
sudo apt install linux-image-4.13.0-21-generic linux-image-extra-4.13.0-21-generic linux-tools-4.13.0-21-generic fdutils linux-headers-4.13.0-21-generic


# get the builder (is also a submodule in https://github.com/0-complexity/G8OS_boot)
git clone git@github.com/PurePeople/911builder 911builder

cd 911builder
# remove ./root when it's your first time
# that way, a debootstrap populates a new tree
rm -rf ./root

# run it
./prepareroot

# debootstrap gets run
# other necessary packages from "pkglist" get installed
# when finished , you'll find a file "ramfs" -> that is the initrd


```

```
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.11'>hvm</type>
    <kernel>/boot/vmlinuz-4.13.0-19-generic</kernel>
    <initrd>/boot/ramfs</initrd>
    <boot dev='hd'/>
  </os>
```

in qemu

or configure pxe to use these files for `linux` and `initrd`

or whatevvah
