#!/bin/bash

# Вывод заголовка скрипта
printf "\nЗапущен скрипт, проверяющий, отличается ли текущая версия релиза от предыдущей.\n\n"

# Определение имени ветки с изменениями
FEATURE_BRANCH_NAME="feature"

# Определение имени временной директории
TMP_FOLDER_NAME="tmp"

# Определение начального числа ошибок
ERROR_COUNT=0

# Определения функций для проверки версий

function version_check_project_version {

     printf "\nПроверяется версия следующего файла:\n"
     echo "$1"

     # Избегание пробелов в аргументе
     CURRENT_TAG_WITHOUT_V=$(echo "$CURRENT_TAG" | sed s/v//)

     echo "$(grep version "$1")"
     echo "version = \"$CURRENT_TAG_WITHOUT_V\""
     if [ "$(grep version "$1")" == "version = \"$CURRENT_TAG_WITHOUT_V\"" ]; then

          printf "\nВерсия в этом файле совпадает с текущей.\n"

     else

          printf "\nВерсия в этом файле НЕ совпадает с текущей.\n"
          ERROR_COUNT=$((ERROR_COUNT+1))

     fi

}

function version_check_project_version_zip {

     printf "\nПроверяется версия следующего файла:\n"
     echo "$2,"
     printf "который находится в следующем .zip архиве:\n"
     echo "$1"

     # Создание временной директории, если она еще не создана
     if [ ! -d $TMP_FOLDER_NAME ]; then
          mkdir $TMP_FOLDER_NAME

     # Удаление всех файлов во временной директории
     else
          rm -rf tmp/*
     fi

     printf "\nРазархивирование во временную директорию...\n"

     # Разархивирование
     unzip -q "$1" -d $TMP_FOLDER_NAME

     if [ "$(grep version "tmp/$2")" == "version = \"$CURRENT_TAG_WITHOUT_V\"" ]; then

          printf "\nВерсия в этом файле совпадает с текущей.\n"

     else

          printf "\nВерсия в этом файле НЕ совпадает с текущей.\n"
          ERROR_COUNT=$((ERROR_COUNT+1))

     fi

}

function run_version_checks {

     version_check_project_version "scats/Project.toml"
     version_check_project_version_zip "archives/scats.zip" "scats/Project.toml"

}

# Переход на ветку master
git checkout -q master

# Сохранение тега последнего коммита на master в переменную
MASTER_TAG="$(git describe --tags master)"

printf "Тег на master:\n"
echo $MASTER_TAG

# Переход на ветку изменений
git checkout -q $FEATURE_BRANCH_NAME

# Получение текущего тега
CURRENT_TAG="$(grep -o "release\-v.*\-informational" README.md | grep -o "\-.*\-" | sed 's/-//g')"

printf "\nТекущий тег из README.md:\n"
echo $CURRENT_TAG

# Проверка, изменился ли текущий тег
if [ $CURRENT_TAG == $MASTER_TAG ]; then

     printf "\nТекущий тег и тег на master совпадают. Обновите текущий тег"
     printf "\nв соответствии с установками Semantic Versioning.\n\n"

     exit 1

fi

# Запуск указанных проверок
run_version_checks

# Избегание точек в текущем теге
CURRENT_TAG="$(echo $CURRENT_TAG | sed 's/v//' | sed 's/\./\\./g')"

# Проверка, совпадает ли другой тег в README.md
if ! grep -q "releases/tag/v$CURRENT_TAG" README.md; then

     printf "\nУказанные теги различаются в README.md.\n\n"

     exit 1

fi

# Проверка числа ошибок
if [ "$ERROR_COUNT" -gt 0 ]; then

     printf "\nЧисло ошибок: $ERROR_COUNT\n\n"
     exit 1

else

     printf "\nВсё в порядке.\n"

fi