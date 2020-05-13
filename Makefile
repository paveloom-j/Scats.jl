
     ## Это шаблон* make-файла для публикации кода на GitHub.

     ## * Изменен для данного репозитория.

     ## Репозиторий на GitHub: https://github.com/Paveloom/B1
     ## Документация: https://www.notion.so/paveloom/B1-fefcaf42ddf541d4b11cfcab63c2f018

     ## Версия релиза: 2.2.1
     ## Версия документации: 2.2.0

     ## Автор: Павел Соболев (http://paveloom.tk)

     ## Для корректного отображения содержимого
     ## символ табуляции должен визуально иметь
     ## ту же длину, что и пять пробелов.

     # Настройки make-файла

     ## Имя координатора
     make := make

     ## Указание оболочки
     SHELL := /bin/bash

     ## Указание make-файлу выполнять все правила в одном вызове оболочки
     .ONESHELL :

     ## Заглушка на вывод информации указанным правилам
     .SILENT :

     ## Правила-псевдоцели
     .PHONY : main, git, git-am, new, del, final, archive

     ## Правило, выполняющееся при вызове координатора без аргументов
     ALL : example-fast


     # Правило для пропуска примера examples/main.jl
     example :
	          cd examples && julia main.jl && cd ../

     # Правило для пропуска примера examples/main.jl с пользовательским образом системы
     example-fast :
	          cd examples && julia --sysimage ../sys_pyplot.so main.jl && cd ../

     # Блок правил для разработки и публикации кода на GitHub

     ## Имя пользователя на GitHub
     username := Paveloom

     ## Сообщение стартового коммита
     start_message := "Стартовый коммит."

     ## Имя ветки изменений
     feature_branch := feature

     ## Правило для создания и публикации коммита
     git :
	     git add -A
	     git commit -e

	     # Проверка, был ли создан коммит
	     if [ $$? -eq 0 ]; then
	          git push
	     fi

     ## Правило для обновления последнего коммита до текущего состояния локального репозитория
     git-am :
	         git add -A
	         git commit --amend

	         # Проверка, был ли создан коммит
	         if [ $$? -eq 0 ]; then

	              git push --force-with-lease

	         fi

     ## Правило для создания ветки изменений
     new :
	      git checkout -q master
	      git checkout -b $(feature_branch)
	      git push -u origin $(feature_branch)

     ## Правило для удаления текущей ветки изменений локально
     del :
	      git checkout -q master
	      git branch -D $(feature_branch)