#!/bin/bash
set -e

rm -f disk.img
truncate -s 100M disk.img
fdisk disk.img << EOF
g
n
1
2048
202751
t
1
p
w
EOF

dd if=../CloverPackage/CloverV2/BootSectors/boot0ss of=disk.img bs=440 count=1 conv=notrunc
mkfs.fat -F32 disk.img --offset=2048
dd if=disk.img of=pbrold bs=512 skip=2048 count=1 conv=notrunc
cp ../CloverPackage/CloverV2/BootSectors/boot1f32 pbrnew
dd if=pbrold of=pbrnew skip=3 seek=3 bs=1 count=87 conv=notrunc
dd if=pbrnew of=disk.img bs=512 count=1 seek=2048 conv=notrunc

EFI=disk.img@@1M
mmd -i "$EFI" ::/EFI ::/EFI/BOOT
grub-mkstandalone -o bootx64.efi -O x86_64-efi "/boot/grub/grub.cfg=grub.cfg" "/boot/grub/layouts/fr.gkb=fr.gkb"
mcopy -i "$EFI" ../Build/Clover/RELEASE_GCC131/FV/boot ::/boot
mcopy -i "$EFI" bootx64.efi ::/EFI/BOOT/BOOTX64.EFI
mcopy -i "$EFI" /usr/share/edk2-shell/x64/Shell_Full.efi ::/shellx64.efi
echo Success
