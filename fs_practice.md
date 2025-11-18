Приклад створення: EXT4
```bash
sudo mkfs.ext4 -L "MyData" /dev/sdb1
```

Приклад створення: XFS
```bash
sudo mkfs.xfs -L "BigData" /dev/sdb1
```

Приклад створення: btrfs
```bash
sudo mkfs.btrfs -L "SnapData" /dev/sdb1

# Створення subvolume
sudo btrfs subvolume create /mnt/data/subvol1

# Snapshot
sudo btrfs subvolume snapshot /mnt/data/subvol1 /mnt/data/snapshot1
```

Приклад створення: OpenZFS
```sh
# Створення pool
sudo zpool create mypool /dev/sdb

# Snapshot
sudo zfs snapshot mypool@snap1

# Compression
sudo zfs set compression=lz4 mypool
```

Мережеві файлові системи
NFS (Network File System)
```sh
sudo mount -t nfs server:/export/share /mnt/nfs
```

Temp FS
```sh
# Монтування
sudo mount -t tmpfs -o size=1G tmpfs /mnt/ramdisk
```

procfs (/proc)
```sh
cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/[PID]/status
```

sysfs (/sys)
```sh
cat /sys/class/net/eth0/address
echo 1 > /sys/class/leds/led0/brightness
```

SquashFS
```sh
# Створення
mksquashfs /source /output.sqsh -comp xz

# Монтування
sudo mount -t squashfs output.sqsh /mnt
```

Практика: Робота з файловими системами в Linux

4.1 Перегляд інформації про файлові системи
Команда df - disk free (вільне місце)

```sh Базове використання
df

# Зручний формат (human-readable)
df -h

# Показати тип файлової системи
df -T

# Інформація про конкретну директорію
df -h /home

# Показати inodes
df -i
```

Приклад виводу:
```
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/sda1      ext4    50G   20G   28G  42% /
/dev/sdb1      xfs    500G  200G  300G  40% /data
tmpfs          tmpfs  7.8G  1.2G  6.6G  16% /tmp
```

Команда lsblk - list block devices
```sh 
Показати всі блочні пристрої
lsblk

# З файловою системою
lsblk -f

# Детальна інформація
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID
```

Команда mount - монтування та перегляд
```sh Показати всі змонтовані ФС
mount | column -t

# Показати тільки певний тип
mount -t ext4

# Монтування розділу
sudo mount /dev/sdb1 /mnt/data

# Монтування з опціями
sudo mount -o ro,noexec /dev/sdb1 /mnt/readonly
```

Команда findmnt - tree-подібний вигляд

```sh Дерево монтованих ФС
findmnt

# Конкретна точка монтування
findmnt /home

# З типом файлової системи
findmnt -t ext4
```

4.2 Детальна інформація про файлову систему
tune2fs - для ext2/3/4

```sh Перегляд параметрів
sudo tune2fs -l /dev/sda1

# Встановити мітку
sudo tune2fs -L "MyDisk" /dev/sda1

# Змінити кількість монтувань перед перевіркою
sudo tune2fs -c 30 /dev/sda1
```

xfs_info - для XFS

```sh
sudo xfs_info /dev/sdb1
```

blkid - UUID та типи
```sh
#Всі блочні пристрої
sudo blkid

# Конкретний пристрій
sudo blkid /dev/sda1

# Тільки UUID
sudo blkid -s UUID -o value /dev/sda1

```

4.3 Аналіз використання диска
du - disk usage
```sh
# Використання директорії
du -sh /home/user

# Топ-10 найбільших директорій
du -h /var | sort -rh | head -10

# З глибиною 1 рівень
du -h --max-depth=1 /var

# Виключити певні директорії
du -h --exclude="*.log" /var
```

ncdu - інтерактивний аналізатор (потрібна установка)
```sh
# Встановлення
sudo apt install ncdu   # Debian/Ubuntu
sudo dnf install ncdu   # Fedora

# Використання
ncdu /home
```

5. Тестування навантаження файлової системи
dd - базове тестування
Тест запису (write test)
```sh
# Запис 1GB файлу
dd if=/dev/zero of=/tmp/testfile bs=1M count=1024 oflag=direct

# З вимірюванням часу
time dd if=/dev/zero of=/tmp/testfile bs=1M count=1024 oflag=direct
```

Тест читання (read test)
```sh
# Очистити кеш перед тестом
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"

# Читання файлу
dd if=/tmp/testfile of=/dev/null bs=1M
```

fio - Flexible I/O Tester (професійний інструмент)

Встановлення:
```sh
sudo apt install fio      # Debian/Ubuntu
sudo dnf install fio      # Fedora
```

Послідовне читання:
```bash
fio --name=seq-read \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=read \
    --bs=128k \
    --direct=1 \
    --size=1G \
    --numjobs=1 \
    --runtime=60 \
    --group_reporting
```

Послідовний запис:
```bash
fio --name=seq-write \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=write \
    --bs=128k \
    --direct=1 \
    --size=1G \
    --numjobs=1 \
    --runtime=60 \
    --group_reporting
```

Випадкове читання (random read):
```bash
fio --name=rand-read \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=randread \
    --bs=4k \
    --direct=1 \
    --size=1G \
    --numjobs=4 \
    --runtime=60 \
    --group_reporting
```

Випадковий запис (random write):
```bash
fio --name=rand-write \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=randwrite \
    --bs=4k \
    --direct=1 \
    --size=1G \
    --numjobs=4 \
    --runtime=60 \
    --group_reporting
```

Змішане навантаження (70% read, 30% write):
```bash
fio --name=mixed \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=randrw \
    --rwmixread=70 \
    --bs=4k \
    --direct=1 \
    --size=1G \
    --numjobs=4 \
    --runtime=60 \
    --group_reporting
```

bonnie++ - комплексне тестування
```bash
# Встановлення
sudo apt install bonnie++

# Запуск тесту
bonnie++ -d /tmp -u root

# З вказаним розміром
bonnie++ -d /mnt/test -s 4G -u root
```

hdparm - тестування швидкості диска
```bash
# Встановлення
sudo apt install hdparm

# Тест читання з кешу
sudo hdparm -t /dev/sda

# Тест прямого читання (bypass cache)
sudo hdparm -T /dev/sda

# Обидва тести
sudo hdparm -tT /dev/sda
```

Інструменти для моніторингу файлових систем
iostat - I/O статистика
```bash
# Встановлення (пакет sysstat)
sudo apt install sysstat

# Базовий вивід
iostat

# Розширена статистика кожні 2 секунди
iostat -x 2

# Для конкретного пристрою
iostat -x /dev/sda 2

# З мегабайтами
iostat -xm 2
```

Ключові метрики:

%util - відсоток використання (100% = насичення)
await - середній час очікування (мс)
r/s, w/s - операції читання/запису за секунду
rkB/s, wkB/s - кілобайти читання/запису за секунду

iotop - top для I/O
```bash
# Встановлення
sudo apt install iotop

# Запуск
sudo iotop

# Показувати тільки активні процеси
sudo iotop -o

# Накопичувальний режим
sudo iotop -a
```

dstat - універсальна статистика
```bash
# Встановлення
sudo apt install dstat

# Базовий вивід
dstat

# CPU, диск, мережа
dstat -cdn

# Детальна дискова статистика
dstat -D sda,sdb --disk

# З топ процесів по I/O
dstat --top-io --top-bio
```

inotify-tools - моніторинг змін файлів
```bash
# Встановлення
sudo apt install inotify-tools

# Спостерігати за директорією
inotifywait -m /var/log

# Рекурсивно з подіями
inotifywait -m -r -e modify,create,delete /home/user

# Запис в лог
inotifywait -m -r /data > /tmp/file-changes.log
```

sar - System Activity Reporter
```bash
# I/O статистика за сьогодні
sar -b

# За конкретний час
sar -b -s 10:00:00 -e 12:00:00

# Дискова активність
sar -d

# Запуск збору даних кожні 10 секунд
sar -d 10
```
smartctl - SMART моніторинг
```bash
# Встановлення
sudo apt install smartmontools

# Інформація про диск
sudo smartctl -i /dev/sda

# Здоров'я диска
sudo smartctl -H /dev/sda

# Повна інформація SMART
sudo smartctl -a /dev/sda

# Тест диска (short)
sudo smartctl -t short /dev/sda

# Перевірити результат тесту
sudo smartctl -l selftest /dev/sda
```

atop - розширений системний монітор
```bash
# Встановлення
sudo apt install atop

# Запуск
atop

# Натисніть 'd' для дискової статистики
```

6.8 Графічні та веб-інтерфейси

Nagios/Icinga - моніторинг інфраструктури
```bash
# Плагін для перевірки диска
/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /
```
Grafana + Prometheus - сучасний стек

Node Exporter для збору метрик
Prometheus для зберігання
Grafana для візуалізації

Netdata - real-time моніторинг

```bash
# Встановлення (автоматичний скрипт)
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# Доступ: http://localhost:19999
```

Практичні сценарії
Сценарій 1: Аналіз повільного диска

```bash
# 1. Перевірити навантаження
iostat -x 2 5

# 2. Знайти процеси з високим I/O
sudo iotop -o

# 3. Перевірити SMART
sudo smartctl -a /dev/sda

# 4. Провести тест
sudo fio --name=test --rw=randrw --size=1G --runtime=60
```

Сценарій 2: Очистка диска
```bash
# 1. Знайти великі файли
find /var -type f -size +100M -exec ls -lh {} \;

# 2. Проаналізувати використання
ncdu /var

# 3. Очистити логи старші 7 днів
find /var/log -name "*.log" -mtime +7 -delete

# 4. Очистити кеш пакетів
sudo apt clean
```
Сценарій 3: Моніторинг виробничої системи
```bash
# Створити скрипт моніторингу
cat > /usr/local/bin/fs-monitor.sh << 'EOF'
#!/bin/bash
while true; do
    echo "=== $(date) ==="
    df -h | grep -E "/$|/home|/var"
    iostat -x 1 1 | grep -E "sda|nvme"
    echo ""
    sleep 300  # кожні 5 хвилин
done
EOF

chmod +x /usr/local/bin/fs-monitor.sh

# Запустити у фоні
nohup /usr/local/bin/fs-monitor.sh > /var/log/fs-monitor.log 2>&1 &
```

8. Висновки
Основні рекомендації:

Регулярний моніторинг - використовуйте iostat, df, du
Автоматизація - налаштуйте алерти при критичних значеннях
Бенчмаркинг - періодично тестуйте продуктивність
SMART моніторинг - відслідковуйте здоров'я дисків
Планування - прогнозуйте зростання даних

Корисні команди для щоденної роботи:
```bash
# Швидкий огляд системи
df -h && free -h && iostat -x 1 1

# Знайти файли, що швидко ростуть
find /var/log -type f -printf '%T@ %s %p\n' | sort -rn | head -20

# Моніторинг у реальному часі
watch -n 2 'df -h | grep -v tmpfs'
```

