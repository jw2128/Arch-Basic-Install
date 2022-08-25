#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Santo_Domingo /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "linux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 linux.localdomain linux" >> /etc/hosts
echo root:password | jwcm.

# Puede eliminar o agregar programa a su gusto y preferencia. 
# Puede eliminar el paquete tlp si no esta utilizando este script en una laptop


pacman -S grub grub-btrfs efibootmgr os-prober ntfs-3g dhcpcd networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset nss-mdns acpid xf86-input-libinput xorg xorg-xinit


  pacman -S xf86-video-intel vulkan-intel
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# cambie el directorio a /boot/efi si montó la partición EFI en /boot/efi

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-install --target=x86_64-efi --efi-directory=/boot --removable

echo 'GRUB_DISABLE_OS_PROBER="false"' >> /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable acpid

useradd -m -g users -G wheel -s /bin/bash juan
echo juan:password | jwcm
usermod -aG libvirt juan

echo "juan ALL=(ALL) ALL" >> /etc/sudoers.d/juan


printf "\e[1;32mHecho! Escribe exit, umount -a and reboot.\e[0m"




