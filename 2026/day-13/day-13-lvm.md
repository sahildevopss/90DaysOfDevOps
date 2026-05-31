# Day 13 – Linux Volume Management (LVM)

## Objective

Today I learned Linux Logical Volume Management (LVM) using AWS attached EBS volumes.

I practiced:

* Creating Physical Volumes (PV)
* Creating Volume Groups (VG)
* Creating Logical Volumes (LV)
* Formatting and mounting volumes
* Extending storage dynamically

---

# Step 1 – Switch to Root User

```bash
sudo -i
```

OR

```bash
sudo su
```

---

# Task 1 – Check Current Storage

## Check Available Disks

```bash
lsblk
```

### Example Output

```bash
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme0n1       259:0    0  20G  0 disk
├─nvme0n1p1   259:1    0   1G  0 part /boot
└─nvme0n1p2   259:2    0  19G  0 part /

nvme1n1       259:3    0  10G  0 disk
```

Here:

* `nvme0n1` → Main OS Disk
* `nvme1n1` → Newly attached AWS EBS Volume

---

## Check Existing Physical Volumes

```bash
pvs
```

### Example Output

```bash
No physical volume found
```

---

## Check Existing Volume Groups

```bash
vgs
```

### Example Output

```bash
No volume groups found
```

---

## Check Existing Logical Volumes

```bash
lvs
```

### Example Output

```bash
No logical volume found
```

---

## Check Disk Usage

```bash
df -h
```

---

# Task 2 – Create Physical Volume

## Create Physical Volume on AWS Disk

```bash
pvcreate /dev/nvme1n1
```

### Output

```bash
Physical volume "/dev/nvme1n1" successfully created.
```

---

## Verify Physical Volume

```bash
pvs
```

### Example Output

```bash
PV             VG   Fmt  Attr PSize PFree
/dev/nvme1n1        lvm2 ---  10.00g 10.00g
```

---

# Task 3 – Create Volume Group

## Create Volume Group

```bash
vgcreate devops-vg /dev/nvme1n1
```

### Output

```bash
Volume group "devops-vg" successfully created
```

---

## Verify Volume Group

```bash
vgs
```

### Example Output

```bash
VG         #PV #LV #SN Attr   VSize  VFree
devops-vg    1   0   0 wz--n- 10.00g 10.00g
```

---

# Task 4 – Create Logical Volume

## Create Logical Volume

```bash
lvcreate -L 500M -n app-data devops-vg
```

### Output

```bash
Logical volume "app-data" created.
```

---

## Verify Logical Volume

```bash
lvs
```

### Example Output

```bash
LV       VG         Attr       LSize
app-data devops-vg -wi-a----- 500.00m
```

---

# Task 5 – Format and Mount Logical Volume

## Format the Logical Volume

```bash
mkfs.ext4 /dev/devops-vg/app-data
```

### Output

```bash
Creating filesystem with ...
Filesystem UUID: xxxxxxxx
```

---

## Create Mount Directory

```bash
mkdir -p /mnt/app-data
```

---

## Mount the Logical Volume

```bash
mount /dev/devops-vg/app-data /mnt/app-data
```

---

## Verify Mounted Filesystem

```bash
df -h /mnt/app-data
```

### Example Output

```bash
Filesystem                        Size Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  487M  24K  452M   1% /mnt/app-data
```

---

# Task 6 – Extend the Logical Volume

## Extend Volume by 200MB

```bash
lvextend -L +200M /dev/devops-vg/app-data
```

### Output

```bash
Size of logical volume devops-vg/app-data changed
```

---

# Understanding resize2fs

After increasing the Logical Volume size, the filesystem still uses the old size.

So we use:

```bash
resize2fs /dev/devops-vg/app-data
```

This command expands the EXT4 filesystem so Linux can use the newly added storage space.

---

## Resize Filesystem

```bash
resize2fs /dev/devops-vg/app-data
```

### Output

```bash
Filesystem resized successfully
```

---

## Verify Extended Storage

```bash
df -h /mnt/app-data
```

### Example Output

```bash
Filesystem                        Size Used Avail Use% Mounted on
/dev/mapper/devops--vg-app--data  682M  25K  640M   1% /mnt/app-data
```

---

# Important LVM Commands Learned

| Command     | Purpose                |
| ----------- | ---------------------- |
| `lsblk`     | Show block devices     |
| `pvs`       | Show Physical Volumes  |
| `vgs`       | Show Volume Groups     |
| `lvs`       | Show Logical Volumes   |
| `pvcreate`  | Create Physical Volume |
| `vgcreate`  | Create Volume Group    |
| `lvcreate`  | Create Logical Volume  |
| `mkfs.ext4` | Format filesystem      |
| `mount`     | Mount filesystem       |
| `lvextend`  | Extend logical volume  |
| `resize2fs` | Resize EXT4 filesystem |
| `df -h`     | Check disk usage       |

---

# What I Learned

## 1. LVM Makes Storage Flexible

LVM allows dynamic resizing of storage without repartitioning disks.

---

## 2. LVM Has Three Main Layers

* Physical Volume (PV)
* Volume Group (VG)
* Logical Volume (LV)

---

## 3. resize2fs Expands Filesystem

After increasing LV size, `resize2fs` allows the filesystem to use the new storage space.

---

# Conclusion

Today I learned Linux LVM using AWS EBS volumes. I practiced creating Physical Volumes, Volume Groups, Logical Volumes, mounting storage, and extending disk space dynamically using LVM.

LVM is very useful in real-world cloud and DevOps environments because storage can be resized without downtime.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
