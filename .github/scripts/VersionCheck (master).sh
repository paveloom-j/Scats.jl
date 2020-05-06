#!/bin/bash

# Вывод заголовка скрипта
printf "\nЗапущен скрипт, проверяющий, отличается ли текущая версия релиза от предыдущей.\n\n"

# Определение имени ветки с изменениями
FEATURE_BRANCH_NAME="feature"

# Переход на ветку master
git checkout -q master

# Сохранение тега последнего коммита на master в переменную
MASTER_TAG="$(git describe --tags master)"

printf "Проверка, совпадает ли тег на master с текущим тегом...\n\n"

# Получение текущего тега
CURRENT_TAG="$(grep -o "release\-v.*\-informational" README.md | grep -o "\-.*\-" | sed 's/-//g')"

printf "Тег на master:\n"
echo $MASTER_TAG

printf "\nТекущий тег из README.md:\n"
echo $CURRENT_TAG

# Проверка, отличается ли тег на master от текущего тега
if [ ! $CURRENT_TAG == $MASTER_TAG ]; then

     printf "\nТекущий тег и тег на master НЕ совпадают.Обновите"
     printf "\nтег на master в соответствии с текущим тегом.\n\n"

     exit 1

fi

printf "\nВсё в порядке.\n"