# Зададим переменные
DATE=$(date +%Y%m%d)

# Для инструкций по восстановлению см. postgresql.org/docs/8.1/static/backup.html
# Устанавливаем разделитель для элементов массива, предварительно резервируя системный:
oldIFS==$IFS
IFS=";"

log_keepdays="14"

# Названия баз данных, которые будем сохранять, перечисленные через разделитель, заданный выше
dump_bases=dp

# Контур сервера БД, проди или тест
group_server=test

#Резервное копирование
cd /
mount -t nfs 192.168.10.100:/backup/pud20 /mnt/backup_pud20

#перемещаем дамп в локальную папку
cp /mnt/backup_pud20/dump_all_$group_server-$DATE.sql /tmp/

#восстанавливаем дамп
sudo -u postgres dropdb dp -f
sudo -u postgres psql -f /tmp/dump_all_$group_server-$DATE.sql  postgres > /home/deploy/$DATE-pgrestore.log 2>&1
find /home/deploy/*-pgrestore.log -mtime +$log_keepdays -exec /bin/rm '{}' \;

# Ищем в каталоге резервных копий все файлы с именами похожими на бэкап текущей БД и старше срока хранения и удаляем
/bin/rm /tmp/dump_all_$group_server-$DATE.sql
umount /mnt/backup_pud20

# Восстанавливаем стандартный (системный) разделитель списков
IFS=$oldIFS
~