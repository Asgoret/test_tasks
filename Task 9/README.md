# Task 9
1. Необходимо выстроить и описать процесс CI/CD для web-проекта, работа которого организована в docker-контейнерах. Входные данные:
    * Язык программирования: PHP 7.3
    * Стек технологий, задействованых в работе проекта: PHP-FPM, MySQL
    * Система управления репозиториями: Gitlab
    * Система CI/CD: Gitlab CI
    * Менеджер репозиториев Docker: Goharbor
    * Система оркестрации Docker: Docker-compose / k8s
    * Система хранения секретов: Gitlab env/Vault
    * Имется 3 сервера для размещения приложения, по одному на каждую среду окружения - dev, stage, prod
    * Имеется 1 tools-сервер, на котором располагается Gitlab, 2 контейнера с Gitlab-runner (один под dev/stage окружения и еще один - для prod), Goharbor
    * Для процессов CI в dev/stage и prod средах должны использоваться разные runner
    * Обновление кода в dev,stage средах должно происходить по push в соответствующую ветку, в prod - при выставлении тэга
    * Необходимо предусмотреть возможность отката на предыдушую версию кода

В качестве результата работы необходимо предоставить:
* доступы к репозиторию Gitlab
* все docker-compose файлы/манифесты Kubernetes - для самого приложения на PHP, Gitlab, Gitlab-runner, Goharbor и Vault (если будет задействован)
* текстовый документ с подробным описанием реализованной схемы и пояснениями ключевых моментов