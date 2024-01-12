# NODE EXPORTER   

### Что делает:  
1. Устанавливает необходимые пакеты  
2. Добавляет пользователя node_exporter  
3. Скачивает и разархивирует архив node_exporter  
4. Добавляет и стартует сервис node_exporter.service  
5. Открывает порт 9100 для сервер(а/ов) мониторинга  

### Локальный запуск:  
```shell
ansible-playbook -i hosts main.yml --private-key ~/Documents/HSE/id_rsa.ci_app --vault-password-file a_password_file -vv  
```

где:   
   `a_password_file` - файл с паролем для открытия ansible-vault secrets  
   `/Documents/HSE/id_rsa.ci_app` - путь до ssh ключа
