import os
import sys

drive_letter = sys.argv[1]

for i in drive_letter:
    if i == "c":
        dnum = 2
    elif i == "d":
        dnum = 3
    elif i == "e":
        dnum = 5

    # check if folder exits
    # TODO: This check doesn't work as expected
    if os.path.exists("/run/media/sda{dnum}") is True:
        print(f"/dev/sda{dnum} exist!")
        break

    # create mountpoint dir before mount it
    os.system(f"mkdir /run/media/sda{dnum}")
    n3g = os.system(f"ntfs-3g /dev/sda{dnum} /run/media/sda{dnum}")

    # ntfs-3g return 4096(letters?) if device already mounted
    if n3g == 4096:
        n3g = os.system(f"umount /dev/sda{dnum}")
        print(f"un-mounted /dev/sda{dnum}")
        break

    # ntfs-3g returns 2816 if device doesn't exits
    if n3g == 2816:
        break

    print(f"mounted /dev/sda{dnum}")
