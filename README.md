## 911builder

### What is dis ?

911 builder creates an initramfs that can bue used with the same kernel as is running on this machine that:
  - runs a complete ubuntu in memory
  - can be booted from pxe
  - can use `apt update`, `atp install`
  - can mount local filesystems, md devices, run filesystem checks, make images...

### How?

Basically : just run `./prepareroot`

That'll create a `ramfs` file. Together with the __running__ kernel of your host,
you can boot it as 

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
