# copy my kernel module info for the jenkins job
modprobed-db list | ssh "$REMOTE_USER@$SERVER" "cat - > /data/kernel/modules"

ssh "$REMOTE_USER@$SERVER" "cat - > /data/kernel/config" << EOF
scripts/config --enable CONFIG_SATA_AHCI
scripts/config --enable CONFIG_BLK_DEV_NVME
scripts/config --enable CONFIG_NVME_FC
scripts/config --enable CONFIG_NVME_TCP
scripts/config --enable CONFIG_NVME_TARGET
scripts/config --enable CONFIG_FAT_FS
scripts/config --enable CONFIG_NLS_ASCII
scripts/config --enable CONFIG_FAT_DEFAULT_UTF8
scripts/config --enable CONFIG_AUTOFS4_FS
scripts/config --enable CONFIG_AUTOFS_FS
scripts/config --enable CONFIG_OVERLAY_FS
scripts/config --enable CONFIG_TASK_DELAY_ACCT

scripts/config --set-str CONFIG_FAT_DEFAULT_IOCHARSET ascii
scripts/config --set-val CONFIG_FAT_DEFAULT_CODEPAGE 437
EOF
