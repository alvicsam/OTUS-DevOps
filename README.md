### Подготовка и запуск

1. Необходим аккаунт в GCP и на docker hub  
2. Настроенная утилита gcloud  
3. Желательно добавить в настройки ~/.ssh/config:
```bash
Host *
    StrictHostKeyChecking no
```
4. Придумать пароль для ansible-vault и положить его в ~/.vault.key
5. Сгенерировать приватный ключ appuser и публичный ключ appuser.pub, положить их к себе в ~/.ssh/  
6. Сгенерировать пароль для gitlab и положить его в ansible/environments/prod/host_vars/gitlab.yml (пароль по умолчанию 123qweasd): 
`ansible-vault encrypt_string "der-parol" --name "gitlab_password" --vault-password-file ~/.vault.key`
7. Настроить файл ansible/secrets.yml.example (прописать логин и пароль от dockerhub), переименовать его в secrets.yml и зашифровать ansible-vault:  
`ansible-vault encrypt ansible/secrets.yml --vault-password-file ~/.vault.key`
8. Переименовать terraform/terraform.tfvars.example в terraform/terraform.tfvars, прописать название проекта gcp (переменная `project`), свой ip (переменная `ip_range`)  
9. Переименовать packer/variables.json.example в packer/variables.json, прописать название проекта gcp (переменная `project_id`)  
10. Запустить step1.sh в формате: `step1.sh <gcp-project-name>`
11. Подождать примерно 3-4 минуты, пока запустится gitlab  
12. Зайти в гитлаб под пользователем root и паролем из пункта 5, создать токен для пользователя со всему правами (http://`terraform output gitlab_external_ip`/profile/personal_access_tokens)  
13. Запустить step2.sh в формате: `step2.sh <gitlab-token> <gitlab password>`  
14. Зайти в проект crawler, найти registration token для runner'ов (http://`terraform output gitlab_external_ip`/root/crawler/settings/ci_cd -> runners -> expand)  
15. Запустить step3.sh в формате: `step3.sh <gitlab-registration-token> <docker-hub-login>`  

На этом этапе можно зайти в pipeline и убедиться, что прошла сборка образов, они залились на docker hub, отработали тесты, а также проект залился на dev-сервер.  
Можно зайти на него по адресу http://`terraform output dev_external_ip`:8000 и сделать поиск по слову page1  

После чего можно запустить деплой на прод, убедиться, что он выполнился, зайти на http://`terraform output prod_external_ip`:8000 и сделать поиск по слову page1.


### Описание того, что происходит в скриптах

step1.sh:  
1. Определяется наш внешний ip и создается разрешающее правило firewall  
2. Создается образ с установленным docker и docker-compose с помощью packer  
3. Накатывается инфрастурктура с помощью terraform: вм gitlab, dev и prod, создаются правила на фаерволе  
4. Устанавливается gitlab (вариант установки omnibus)  

step2.sh:  
1. В гитлабе создается проект crawler
2. Скачиваются ui и crawler с github, объединяются и заливаются в проект на гитлаб

step3.sh
1. Настраиваются gitlab-runner на dev и prod
2. Настраивается docker login на dev, чтобы заливать образы на docker hub
3. Заливается docker-compose в проект
4. Заливается .gitlab-ci.yml в проект


### Резюме того, что было сделано

1. Скачаны приложения crawler и ui, изучен запуск руками  
2. Написан Dockerfile для этих приложений  
3. Написан docker-compose  
4. Создан файл для сборки packer  
5. Созданы файлы и модули для terraform  
6. Создана типовая иерархия файлов для ansible  
6. Написана роль gitlab-omnibus  
7. Создан pipeline описанный в .gitlab-ci.yml  
8. Написаны bash-скрипты для автоматизации настройки  
9. Написана документация  

### Полезная инфа для себя 

rabbitmq create queue on container start https://medium.com/@thomasdecaux/deploy-rabbitmq-with-docker-static-configuration-23ad39cdbf39  
Создать очередь в контейнере: `curl -i -u rabbitmq:rabbitmq -H "content-type:application/json" -XPUT -d'{"durable":false}' http://127.0.0.1:15672/api/queues/%2f/rabbitmq`
