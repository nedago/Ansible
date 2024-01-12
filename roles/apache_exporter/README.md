# APACHE EXPORTER   

### Что делает:  
1. Устанавливает необходимые пакеты  
2. Добавляет пользователя apache_exporter  
3. Скачивает и разархивирует архив apache_exporter  (https://github.com/Lusitaniae/apache_exporter)  
4. Добавляет и стартует сервис apache_exporter.service  
5. Открывает порт 9117 для сервер(а/ов) мониторинга  

### Локальный запуск:  
```shell
ansible-playbook -i hosts main.yml --private-key ~/Documents/HSE/id_rsa.ci_app --vault-password-file a_password_file -vv  
```

где:   
   `a_password_file` - файл с паролем для открытия ansible-vault secrets  
   `/Documents/HSE/id_rsa.ci_app` - путь до ssh ключа  
   
 
----
## Подготовительные работы на сервере  
Для вывода метрик необходимо активировать server-status  
для этого:  

Включение server-status на apache2/httpd в Ubuntu и CentOS
server-status это модуль веб-сервера, который может помочь установить какой из сайтов на сервере создает нагрузку или даже покажет на какой именно скрипт на сайте идет больше всего обращений. В общем это модуль который помогает в мониторинге состояния веб-сервера. Разберёмся как его установить.

В centos он обычно уже установлен. В ubuntu смотрим:
`ls /etc/apache2/mods-enabled`
Если в выводе есть status.load и status.conf, то значит он тоже установлен. Если же нет, то выполняем:
`/usr/sbin/a2enmod status`
Затем открываем конфигурационный файл веб-сервера, в centos — /etc/httpd/conf/httpd.conf, в ubuntu — /etc/apache2/apache2.conf. Добавляем туда:
```
ExtendedStatus On
<Location /server-status>
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from 127.0.0.1
</Location>
```
Затем перезапускаем апач.
в Ubuntu:
`service apache2 restart`
в CentOS:
`service httpd restart`


