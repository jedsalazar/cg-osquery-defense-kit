SELECT description AS "desc",
    fragment_path AS path,
    hash.sha256,
    file.ctime,
    file.size,
    CONCAT(
        id,
        ",",
        description,
        ",",
        user,
        ",",
        (file.size / 100) * 100
    ) AS exception_key
FROM systemd_units
    LEFT JOIN hash ON systemd_units.fragment_path = hash.path
    LEFT JOIN file ON systemd_units.fragment_path = file.path
WHERE active_state != "inactive"
    AND sub_state != "plugged"
    AND sub_state != "mounted"
    AND fragment_path != ""
    AND NOT (
        (
            -- Only allow fragment paths in known good directories
            fragment_path LIKE "/lib/systemd/system/%"
            OR fragment_path LIKE "/usr/lib/systemd/system/%"
            OR fragment_path LIKE "/etc/systemd/system/%"
            OR fragment_path LIKE "/run/systemd/generator/%"
            OR fragment_path LIKE "/run/systemd/generator.late/%.service"
            OR fragment_path LIKE "/run/systemd/transient/%"
        )
        AND (
            exception_key IN (
                "abrt-journal-core.service,Creates ABRT problems from coredumpctl messages,,200",
                "abrt-oops.service,ABRT kernel log watcher,,200",
                "abrt-xorg.service,ABRT Xorg log watcher,,200",
                "abrtd.service,ABRT Automated Bug Reporting Tool,,400",
                "accounts-daemon.service,Accounts Service,,1900",
                "accounts-daemon.service,Accounts Service,,2100",
                "accounts-daemon.service,Accounts Service,,700",
                "acpid.path,ACPI Events Check,,100",
                "acpid.service,ACPI event daemon,,200",
                "acpid.socket,ACPID Listen Socket,,100",
                "akmods-keygen.target,akmods-keygen.target,,0",
                "akmods.service,Builds and install new kmods from akmod packages,,300",
                "alsa-restore.service,Save/Restore Sound Card State,,400",
                "alsa-restore.service,Save/Restore Sound Card State,,600",
                "alsa-state.service,Manage Sound Card State (restore and store),,400",
                "alsa-store.service,Store Sound Card State,,1200",
                "anacron.service,Run anacron jobs,,700",
                "anacron.timer,Trigger anacron every hour,,100",
                "apcupsd.service,APC UPS Power Control Daemon for Linux,,300",
                "apparmor.service,Load AppArmor profiles,,1100",
                "apport.service,LSB: automatic crash report generation,,500",
                "apt-daily-upgrade.timer,Daily apt upgrade and clean activities,,100",
                "apt-daily.timer,Daily apt download activities,,100",
                "archlinux-keyring-wkd-sync.timer,Refresh existing PGP keys of archlinux-keyring regularly,,100",
                "audit.service,Kernel Auditing,,1200",
                "auditd.service,Security Auditing Service,,1700",
                "avahi-daemon.service,Avahi mDNS/DNS-SD Stack,,1000",
                "avahi-daemon.socket,Avahi mDNS/DNS-SD Stack Activation Socket,,800",
                "basic.target,Basic System,,900",
                "blk-availability.service,Availability of block devices,,300",
                "blockdev@dev-mapper-cryptoswap.target,Block Device Preparation for /dev/mapper/cryptoswap,,400",
                "bluetooth.service,Bluetooth service,,700",
                "bluetooth.target,Bluetooth Support,,400",
                "bolt.service,Thunderbolt system service,,600",
                "chronyd.service,NTP client/server,,1500",
                "colord.service,Manage, Install and Generate Color Profiles,colord,200",
                "console-setup.service,Set console font and keymap,,300",
                "containerd.service,containerd container runtime,,1200",
                "cron.service,Regular background program processing daemon,,300",
                "cronie.service,Periodic Command Scheduler,,100",
                "cryptsetup.target,Local Encrypted Volumes,,400",
                "cups-browsed.service,Make remote CUPS printers available locally,,200",
                "cups.path,CUPS Scheduler,,100",
                "cups.service,CUPS Scheduler,,200",
                "cups.socket,CUPS Scheduler,,100",
                "dbus-broker.service,D-Bus System Message Bus,,500",
                "dbus.service,D-Bus System Message Bus,,400",
                "dbus.service,D-Bus System Message Bus,,500",
                "dbus.socket,D-Bus System Message Bus Socket,,100",
                "dhcpcd.service,DHCP Client,,1700",
                "display-manager.service,X11 Server,,1700",
                "dkms.service,Builds and install new kernel modules through DKMS,,200",
                "dm-event.socket,Device-mapper event daemon FIFOs,,200",
                "dnf-makecache.service,dnf makecache,,400",
                "dnf-makecache.timer,dnf makecache --timer,,300",
                "docker.service,Docker Application Container Engine,,1100",
                "docker.service,Docker Application Container Engine,,1200",
                "docker.service,Docker Application Container Engine,,1300",
                "docker.service,Docker Application Container Engine,,1700",
                "docker.socket,Docker Socket for the API,,100",
                "docker.socket,Docker Socket for the API,,200",
                "dpkg-db-backup.timer,Daily dpkg database backup timer,,100",
                "dracut-shutdown.service,Restore /run/initramfs on shutdown,,500",
                "e2scrub_all.timer,Periodic ext4 Online Metadata Check for All Filesystems,,200",
                "firewall.service,Firewall,,1500",
                "firewalld.service,firewalld - dynamic firewall daemon,,600",
                "flatpak-system-helper.service,flatpak system helper,,200",
                "fprintd.service,Fingerprint Authentication Daemon,,800",
                "fprintd.service,Fingerprint Authentication Daemon,,900",
                "fstrim.timer,Discard unused blocks once a week,,200",
                "fwupd-refresh.service,Refresh fwupd metadata and update motd,fwupd-refresh,400",
                "fwupd-refresh.timer,Refresh fwupd metadata regularly,,100",
                "fwupd.service,Firmware update daemon,,600",
                "gdm.service,GNOME Display Manager,,800",
                "gdm.service,GNOME Display Manager,,900",
                "geoclue.service,Location Lookup Service,geoclue,400",
                "getty-pre.target,Preparation for Logins,,500",
                "getty.target,Login Prompts,,500",
                "graphical.target,Graphical Interface,,600",
                "gssproxy.service,GSSAPI Proxy Daemon,,400",
                "import-state.service,Import network configuration from initramfs,,400",
                "integritysetup.target,Local Integrity Protected Volumes,,400",
                "irqbalance.service,irqbalance daemon,,500",
                "iscsid.socket,Open-iSCSI iscsid Socket,,100",
                "iscsiuio.socket,Open-iSCSI iscsiuio Socket,,100",
                "iwd.service,Wireless service,,500",
                "kerneloops.service,Tool to automatically collect and submit kernel crash signatures,kernoops,300",
                "keyboard-setup.service,Set the console keyboard layout,,200",
                "kmod-static-nodes.service,Create List of Static Device Nodes,,700",
                "kolide-launcher.service,Kolide launcher,,1900",
                "launcher.kolide-k2.service,The Kolide Launcher,,200",
                "ldconfig.service,Rebuild Dynamic Linker Cache,,600",
                "libvirtd-admin.socket,Libvirt admin socket,,200",
                "libvirtd-ro.socket,Libvirt local read-only socket,,200",
                "libvirtd.service,Virtualization daemon,,1900",
                "libvirtd.socket,Libvirt local socket,,200",
                "lightdm.service,Light Display Manager,,300",
                "livesys-late.service,SYSV: Late init script for live image.,,500",
                "livesys.service,LSB: Init script for live image.,,500",
                "lm_sensors.service,Initialize hardware monitoring sensors,,300",
                "local-fs-pre.target,Preparation for Local File Systems,,400",
                "local-fs.target,Local File Systems,,500",
                "logrotate-checkconf.service,Logrotate configuration check,,1100",
                "logrotate.timer,Daily rotation of log files,,100",
                "logrotate.timer,logrotate.timer,,0",
                "low-memory-monitor.service,Low Memory Monitor,,600",
                "lvm2-lvmpolld.socket,LVM2 poll daemon socket,,200",
                "lvm2-monitor.service,Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling,,500",
                "lvm2-monitor.service,Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling,,600",
                "machine-qemu\\x2d2\\x2dwin10.scope,Virtual Machine qemu-2-win10,,300",
                "machine.slice,Virtual Machine and Container Slice,,400",
                "machines.target,Containers,,400",
                "man-db.timer,Daily man-db regeneration,,100",
                "ModemManager.service,Modem Manager,root,400",
                "ModemManager.service,Modem Manager,root,500",
                "modprobe@efi_pstore.service,Load Kernel Module efi_pstore,,500",
                "modprobe@pstore_blk.service,Load Kernel Module pstore_blk,,500",
                "modprobe@pstore_zone.service,Load Kernel Module pstore_zone,,500",
                "modprobe@ramoops.service,Load Kernel Module ramoops,,500",
                "motd-news.timer,Message of the Day,,100",
                "mount-pstore.service,mount-pstore.service,,1100",
                "multi-user.target,Multi-User System,,500",
                "network-interfaces.target,All Network Interfaces (deprecated),,100",
                "network-local-commands.service,Extra networking commands.,,1300",
                "network-online.target,Network is Online,,500",
                "network-pre.target,Preparation for Network,,500",
                "network-setup.service,Networking Setup,,1300",
                "network.target,Network,,500",
                "networkd-dispatcher.service,Dispatcher daemon for systemd-networkd,,200",
                "NetworkManager-dispatcher.service,Network Manager Script Dispatcher Service,,600",
                "NetworkManager-wait-online.service,Network Manager Wait Online,,1100",
                "NetworkManager.service,Network Manager,,1300",
                "nfs-client.target,NFS client services,,400",
                "nginx.service,Nginx Web Server,nginx,2400",
                "nix-daemon.service,Nix Daemon,,400",
                "nix-daemon.socket,Nix Daemon Socket,,200",
                "nix-gc.timer,nix-gc.timer,,0",
                "nscd.service,Name Service Cache Daemon,nscd,1700",
                "nscd.service,Name Service Cache Daemon,nscd,1800",
                "nss-lookup.target,Host and Network Name Lookups,,500",
                "nss-user-lookup.target,User and Group Name Lookups,,500",
                "nvidia-persistenced.service,NVIDIA Persistence Daemon,,300",
                "openvpn.service,OpenVPN service,,200",
                "packagekit.service,PackageKit Daemon,root,300",
                "paths.target,Path Units,,400",
                "pcscd.service,PC/SC Smart Card Daemon,,200",
                "pcscd.socket,PC/SC Smart Card Daemon Activation Socket,,100",
                "phpsessionclean.timer,Clean PHP session files every 30 mins,,100",
                "plocate-updatedb.timer,Update the plocate database daily,,100",
                "plymouth-quit-wait.service,Hold until boot process finishes up,,200",
                "plymouth-read-write.service,Tell Plymouth To Write Out Runtime Data,,200",
                "plymouth-start.service,Show Plymouth Boot Screen,,500",
                "plymouth-start.service,Show Plymouth Boot Screen,,600",
                "polkit.service,Authorization Manager,,100",
                "polkit.service,Authorization Manager,,200",
                "power-profiles-daemon.service,Power Profiles daemon,,600",
                "power-profiles-daemon.service,Power Profiles daemon,,700",
                "proc-sys-fs-binfmt_misc.automount,Arbitrary Executable File Formats File System Automount Point,,700",
                "qemu-kvm.service,QEMU KVM preparation - module, ksm, hugepages,,300",
                "raid-check.timer,Weekly RAID setup health check,,100",
                "reflector.timer,Refresh Pacman mirrorlist weekly with Reflector.,,100",
                "reload-systemd-vconsole-setup.service,Reset console on configuration changes,,1200",
                "remote-fs-pre.target,Preparation for Remote File Systems,,400",
                "remote-fs.target,Remote File Systems,,500",
                "resolvconf.service,resolvconf update,,1100",
                "rpc_pipefs.target,rpc_pipefs.target,,0",
                "rpc-statd-notify.service,Notify NFS peers of a restart,,300",
                "rsyslog.service,System Logging Service,,400",
                "rtkit-daemon.service,RealtimeKit Scheduling Policy Service,,1000",
                "setvtrgb.service,Set console scheme,,300",
                "shadow.service,Verify integrity of password and group files,,300",
                "shadow.timer,Daily verification of password and group files,,100",
                "slices.target,Slice Units,,400",
                "smartcard.target,Smart Card,,400",
                "snapd.apparmor.service,Load AppArmor profiles managed internally by snapd,,800",
                "snapd.seeded.service,Wait until snapd is fully seeded,,300",
                "snapd.service,Snap Daemon,,400",
                "snapd.service,Snap Daemon,,500",
                "snapd.socket,Socket activation for snappy daemon,,200",
                "sockets.target,Socket Units,,400",
                "sound.target,Sound Card,,400",
                "sshd.service,OpenSSH Daemon,,200",
                "sshd.service,SSH Daemon,,1600",
                "sssd-kcm.service,SSSD Kerberos Cache Manager,,400",
                "sssd-kcm.socket,SSSD Kerberos Cache Manager responder socket,,100",
                "swap.target,Swaps,,400",
                "switcheroo-control.service,Switcheroo Control Proxy service,,400",
                "sysinit.target,System Initialization,,500",
                "syslog.socket,Syslog Socket,,1400",
                "sysstat-collect.timer,Run system activity accounting tool every 10 minutes,,300",
                "sysstat-summary.timer,Generate summary of yesterday's process accounting,,300",
                "sysstat.service,Resets System Activity Logs,root,400",
                "systemd-ask-password-console.path,Dispatch Password Requests to Console Directory Watch,,700",
                "systemd-ask-password-plymouth.path,Forward Password Requests to Plymouth Directory Watch,,400",
                "systemd-ask-password-plymouth.path,Forward Password Requests to Plymouth Directory Watch,,500",
                "systemd-ask-password-wall.path,Forward Password Requests to Wall Directory Watch,,600",
                "systemd-binfmt.service,Set Up Additional Binary Formats,,1200",
                "systemd-boot-update.service,Automatic Boot Loader Update,,600",
                "systemd-coredump.socket,Process Core Dump Socket,,500",
                "systemd-cryptsetup@cryptoswap.service,Cryptography Setup for cryptoswap,,900",
                "systemd-fsckd.socket,fsck to fsckd communication Socket,,500",
                "systemd-homed-activate.service,Home Area Activation,,600",
                "systemd-homed.service,Home Area Manager,,1300",
                "systemd-hostnamed.service,Hostname Service,,1100",
                "systemd-hostnamed.service,Hostname Service,,1200",
                "systemd-initctl.socket,initctl Compatibility Named Pipe,,500",
                "systemd-journal-catalog-update.service,Rebuild Journal Catalog,,700",
                "systemd-journal-flush.service,Flush Journal to Persistent Storage,,800",
                "systemd-journald-audit.socket,Journal Audit Socket,,600",
                "systemd-journald-dev-log.socket,Journal Socket (/dev/log),,1100",
                "systemd-journald.service,Journal Service,,1800",
                "systemd-journald.socket,Journal Socket,,900",
                "systemd-localed.service,Locale Service,,1200",
                "systemd-logind.service,User Login Management,,2000",
                "systemd-logind.service,User Login Management,,2100",
                "systemd-machined.service,Virtual Machine and Container Registration Service,,1200",
                "systemd-machined.service,Virtual Machine and Container Registration Service,,1300",
                "systemd-modules-load.service,Load Kernel Modules,,1000",
                "systemd-network-generator.service,Generate network units from Kernel command line,,600",
                "systemd-oomd.service,Userspace Out-Of-Memory (OOM) Killer,systemd-oom,1600",
                "systemd-oomd.socket,Userspace Out-Of-Memory (OOM) Killer Socket,,600",
                "systemd-random-seed.service,Load/Save Random Seed,,1100",
                "systemd-random-seed.service,Load/Save Random Seed,,1200",
                "systemd-remount-fs.service,Remount Root and Kernel File Systems,,700",
                "systemd-remount-fs.service,Remount Root and Kernel File Systems,,800",
                "systemd-resolved.service,Network Name Resolution,systemd-resolve,1700",
                "systemd-rfkill.socket,Load/Save RF Kill Switch Status /dev/rfkill Watch,,700",
                "systemd-sysctl.service,Apply Kernel Variables,,700",
                "systemd-sysusers.service,Create System Users,,1000",
                "systemd-timesyncd.service,Network Time Synchronization,systemd-timesync,1700",
                "systemd-timesyncd.service,Network Time Synchronization,systemd-timesync,1800",
                "systemd-tmpfiles-clean.timer,Daily Cleanup of Temporary Directories,,500",
                "systemd-tmpfiles-setup-dev.service,Create Static Device Nodes in /dev,,700",
                "systemd-tmpfiles-setup.service,Create Volatile Files and Directories,,700",
                "systemd-tmpfiles-setup.service,Create Volatile Files and Directories,,800",
                "systemd-udev-settle.service,Wait for udev To Complete Device Initialization,,800",
                "systemd-udev-trigger.service,Coldplug All udev Devices,,700",
                "systemd-udevd-control.socket,udev Control Socket,,600",
                "systemd-udevd-kernel.socket,udev Kernel Socket,,600",
                "systemd-udevd.service,Rule-based Manager for Device Events and Files,,1200",
                "systemd-udevd.service,Rule-based Manager for Device Events and Files,,1300",
                "systemd-update-done.service,Update is Completed,,600",
                "systemd-update-done.service,Update is Completed,,700",
                "systemd-update-utmp.service,Record System Boot/Shutdown in UTMP,,700",
                "systemd-update-utmp.service,Record System Boot/Shutdown in UTMP,,800",
                "systemd-update-utmp.service,Record System Boot/Shutdown in UTMP,,900",
                "systemd-user-sessions.service,Permit User Sessions,,600",
                "systemd-user-sessions.service,Permit User Sessions,,700",
                "systemd-userdbd.service,User Database Manager,,1100",
                "systemd-userdbd.socket,User Database Manager Socket,,600",
                "systemd-vconsole-setup.service,Setup Virtual Console,,600",
                "tailscaled.service,Tailscale node agent,,600",
                "tailscaled.service,Tailscale node agent,,700",
                "time-set.target,System Time Set,,400",
                "timers.target,Timer Units,,400",
                "tlp.service,TLP system startup/shutdown,,500",
                "ua-timer.timer,Ubuntu Advantage Timer for running repeated jobs,,100",
                "udisks2.service,Disk Manager,,200",
                "ufw.service,Uncomplicated firewall,,300",
                "unattended-upgrades.service,Unattended Upgrades Shutdown,,300",
                "unbound-anchor.timer,daily update of the root trust anchor for DNSSEC,,300",
                "update-notifier-download.timer,Download data for packages that failed at package install time,,200",
                "update-notifier-motd.timer,Check to see whether there is a new version of Ubuntu available,,300",
                "updatedb.timer,Daily locate database update,,100",
                "upower.service,Daemon for power management,,900",
                "uresourced.service,User resource assignment daemon,,300",
                "user.slice,User and Session Slice,,400",
                "uuidd.socket,UUID daemon activation socket,,100",
                "veritysetup.target,Local Verity Protected Volumes,,400",
                "virtinterfaced.socket,Libvirt interface local socket,,200",
                "virtlockd.socket,Virtual machine lock manager socket,,100",
                "virtlogd-admin.socket,Virtual machine log manager socket,,200",
                "virtlogd.service,Virtual machine log manager,,800",
                "virtlogd.socket,Virtual machine log manager socket,,100",
                "virtnetworkd.socket,Libvirt network local socket,,200",
                "virtnodedevd.socket,Libvirt nodedev local socket,,200",
                "virtnwfilterd.socket,Libvirt nwfilter local socket,,200",
                "virtproxyd.socket,Libvirt proxy local socket,,300",
                "virtqemud-admin.socket,Libvirt qemu admin socket,,200",
                "virtqemud-ro.socket,Libvirt qemu local read-only socket,,200",
                "virtqemud.socket,Libvirt qemu local socket,,200",
                "virtsecretd.socket,Libvirt secret local socket,,200",
                "virtstoraged.socket,Libvirt storage local socket,,200",
                "whoopsie.path,Start whoopsie on modification of the /var/crash directory,,100",
                "wpa_supplicant.service,WPA supplicant,,300",
                "zfs-import-cache.service,Import ZFS pools by cache file,,500",
                "zfs-import.target,ZFS pool import target,,100",
                "zfs-load-key-rpool.service,Load ZFS key for rpool,,700",
                "zfs-load-module.service,Install ZFS kernel module,,300",
                "zfs-mount.service,Mount ZFS filesystems,,300",
                "zfs-mount.service,Mount ZFS filesystems,,400",
                "zfs-scrub.timer,zfs-scrub.timer,,0",
                "zfs-share.service,ZFS file system shares,,400",
                "zfs-snapshot-daily.service,ZFS auto-snapshotting every day,,1000",
                "zfs-snapshot-daily.timer,zfs-snapshot-daily.timer,,0",
                "zfs-snapshot-frequent.service,ZFS auto-snapshotting every 15 mins,,1000",
                "zfs-snapshot-frequent.timer,zfs-snapshot-frequent.timer,,0",
                "zfs-snapshot-hourly.service,ZFS auto-snapshotting every hour,,1000",
                "zfs-snapshot-hourly.timer,zfs-snapshot-hourly.timer,,0",
                "zfs-snapshot-monthly.timer,zfs-snapshot-monthly.timer,,0",
                "zfs-snapshot-weekly.timer,zfs-snapshot-weekly.timer,,0",
                "zfs-volume-wait.service,Wait for ZFS Volume (zvol) links in /dev,,200",
                "zfs-volumes.target,ZFS volumes are ready,,100",
                "zfs-zed.service,ZFS Event Daemon (zed),,200",
                "zfs.target,ZFS startup target,,0",
                "znapzend.service,ZnapZend - ZFS Backup System,root,1700",
                "zpool-trim.timer,zpool-trim.timer,,0"
            )
            OR exception_key LIKE "machine-qemu%,Virtual Machine qemu%,,300"
            OR id LIKE "blockdev@dev-mapper-luks%.target"
            OR id LIKE "blockdev@dev-mapper-nvme%.target"
            OR id LIKE "dbus-:%-org.freedesktop.problems@0.service"
            OR id LIKE "dev-disk-by%.swap"
            OR id LIKE "dev-mapper-%.swap"
            OR id LIKE "dev-zram%.swap"
            OR id LIKE "docker-%.scope"
            OR id LIKE "getty@tty%.service"
            OR id LIKE "home-manager-%.service"
            OR id LIKE "lvm2-pvscan@%.service"
            OR id LIKE "session-%.scope"
            OR id LIKE "system-systemd%cryptsetup.slice"
            OR id LIKE "systemd-backlight@%.service"
            OR id LIKE "systemd-cryptsetup@luks%.service"
            OR id LIKE "systemd-cryptsetup@nvme%.service"
            OR id LIKE "systemd-fsck@dev-disk-by%service"
            OR id LIKE "systemd-zram-setup@zram%.service"
            OR id LIKE "user-runtime-dir@%.service"
            OR id LIKE "user@%.service"
            OR id LIKE "akmods@%64.service"
        )
    )