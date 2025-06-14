#!/bin/bash

ZSHRC="$HOME/.zshrc"
BASHRC="$HOME/.bashrc"

# Тело функции epm-help
EPM_HELP_FUNC=$(cat <<'EOF'
# -------- Алиас для epm --------
eepm-help() {
  echo
  echo -e "\033[1;33mepm - \033[1;37mПакетный менеджер Etersoft \033[0m"
  echo -e "\033[1;32mИспользование:\033[0m epm {команда} [аргументы]"
  echo

  ##########################
  # 1. Работа с пакетами
  ##########################
  echo -e "\033[1;36m[ Работа с пакетами ]\033[0m"
  printf "┌─────────────────────────────────┬─────────────────────────────────────────────────────┐\n"
  printf "│ \033[1;33mКоманда epm\033[0m                     │ \033[1;37mОписание\033[0m                                            │\n"
  printf "├─────────────────────────────────┼─────────────────────────────────────────────────────┤\n"
  printf "│ \033[1;33mepm i\033[0m <pkg>|<file>              │ Установка пакета из репозитория или файла           │\n"
  printf "│ \033[1;33mepm e\033[0m <pkg>                     │ Удаление пакета                                     │\n"
  printf "│ \033[1;33mepm s\033[0m <text>                    │ Поиск пакета в репозитории                          │\n"
  printf "│ \033[1;33mepm q\033[0m <pkg>                     │ Проверка, установлен ли пакет                       │\n"
  printf "│ \033[1;33mepm qa\033[0m                          │ Список всех установленных пакетов                   │\n"
  printf "│ \033[1;33mepm qp\033[0m <word>                   │ Поиск по названиям установленных пакетов            │\n"
  printf "│ \033[1;33mepm qf\033[0m <file>                   │ Какому пакету принадлежит файл                      │\n"
  printf "│ \033[1;33mepm sf\033[0m <file>                   │ В каком пакете содержится указанный файл            │\n"
  printf "│ \033[1;33mepm ql\033[0m <pkg>                    │ Список файлов в установленном пакете                │\n"
  printf "│ \033[1;33mepm qi\033[0m <pkg>                    │ Информация о пакете                                 │\n"
  printf "└─────────────────────────────────┴─────────────────────────────────────────────────────┘\n"
  echo

  ##########################
  # 2. Работа с системой
  ##########################
  echo -e "\033[1;36m[ Работа с системой ]\033[0m"
  printf "┌─────────────────────────────────┬─────────────────────────────────────────────────────┐\n"
  printf "│ \033[1;33mКоманда epm\033[0m                     │ \033[1;37mОписание\033[0m                                            │\n"
  printf "├─────────────────────────────────┼─────────────────────────────────────────────────────┤\n"
  printf "│ \033[1;33mepm update\033[0m                      │ Обновить список доступных пакетов                   │\n"
  printf "│ \033[1;33mepm kernel-upgrade\033[0m              │ Обновления ядра системы                             │\n"
  printf "│ \033[1;33mepm upgrade\033[0m                     │ Обновление дистрибутива (без ядра)                  │\n"
  printf "│ \033[1;33mepm full-upgrade\033[0m                │ Полное обновление системы (включая ядро)            │\n"
  printf "│ \033[1;33mepm ei\033[0m                          │ Обновление утилиты epm                              │\n"
  printf "│ \033[1;33mepm print info\033[0m                  │ Вывод информации о системе                          │\n"
  printf "│ \033[1;33mepm repolist\033[0m                    │ Вывод доступных репозиториев в системе              │\n"
  printf "│ \033[1;33mepm addrepo \033[0m<url>|<name>|<path> │ Добавление репозитория пакетов в систему            │\n"
  printf "│ \033[1;33mepm removerepo\033[0m                  │ Удаление репозитория пактов из системы              │\n"
  printf "│ \033[1;33mepm clean\033[0m                       │ Очистка локального кэша пакетов                     │\n"
  printf "│ \033[1;33mepm autoremove\033[0m                  │ Удаление ненужных пакетов                           │\n"
  printf "└─────────────────────────────────┴─────────────────────────────────────────────────────┘\n"
  echo

  ##########################
  # 3. epm play (приложения)
  ##########################
  echo -e "\033[1;36m[ Работа с приложениями (epm play) ]\033[0m"
  printf "┌─────────────────────────────────┬─────────────────────────────────────────────────────┐\n"
  printf "│ \033[1;33mКоманда epm\033[0m                     │ \033[1;37mОписание\033[0m                                            │\n"
  printf "├─────────────────────────────────┼─────────────────────────────────────────────────────┤\n"
  printf "│ \033[1;33mepm play\033[0m                        │ Список доступных к установке приложений             │\n"
  printf "│ \033[1;33mepm play --list\033[0m                 │ Список установленных приложений                     │\n"
  printf "│ \033[1;33mepm play --list-scripts\033[0m         │ Список установленных утилит                         │\n"
  printf "│ \033[1;33mepm play\033[0m <pkg>                  │ Установка указанного приложения                     │\n"
  printf "│ \033[1;33mepm play --remove\033[0m <pkg>         │ Удаление указанного приложения                      │\n"
  printf "│ \033[1;33mepm play --update \033[0m<pkg>         │ Обновить приложение                                 │\n"
  printf "│ \033[1;33mepm play --update all\033[0m           │ Обновить все приложения                             │\n"
  printf "│ \033[1;33mepm play --installed\033[0m <pkg>      │ Проверка, установлено ли приложение                 │\n"
  printf "└─────────────────────────────────┴─────────────────────────────────────────────────────┘\n"
  echo

  ##########################
  # 4. epm repack
  ##########################
  echo -e "\033[1;36m[ Конвертирование пакетов в стандарт RPM семейства АЛЬТ (epm repack) ]\033[0m"
  echo -e "Поддерживаемые менеджеры: deb, rpm, tgz, tbz, tbz2, apk, pkg.gz, AppImage"
  printf "┌─────────────────────────────────┬─────────────────────────────────────────────────────┐\n"
  printf "│ \033[1;33mКоманда epm\033[0m                     │ \033[1;37mОписание\033[0m                                            │\n"
  printf "├─────────────────────────────────┼─────────────────────────────────────────────────────┤\n"
  printf "│ \033[1;33mepm repack\033[0m <pkg>                │ Перепаковка установленного пакета                   │\n"
  printf "└─────────────────────────────────┴─────────────────────────────────────────────────────┘\n"
  echo

  ##########################
  # 5. epm tool
  ##########################

echo -e "\033[1;36m[ Встроенные инструменты epm (epm tool) ]\033[0m"
echo
echo "\033[1;36mРабота с архивами\033[0m"
echo "*необходимо установить пакет patool"
printf "┌──────────────────────────────────────┬────────────────────────────────────────────────┐\n"
printf "│ \033[1;33mКоманда epm\033[0m                          │ \033[1;37mОписание\033[0m                                       │\n"
printf "├──────────────────────────────────────┼────────────────────────────────────────────────┤\n"
printf "│ \033[1;33mepm tool erc \033[0m<folder>\033[0m                │ Создать архив из папки                         │\n"
printf "│ \033[1;33mepm tool erc a \033[0m<arch> <files>\033[0m        │ Добавить файлы в архив                         │\n"
printf "│ \033[1;33mepm tool erc l \033[0m<arch>\033[0m                │ Вывести список файлов внутри архива            │\n"
printf "│ \033[1;33mepm tool erc repack \033[0m<arch> <format>:\033[0m │ Перепаковать архив/ы в другой формат           │\n"
printf "│ \033[1;33mepm tool erc repack \033[0m<arch> <arch2>\033[0m   │ Перепаковать созданный в новый архив           │\n"
printf "│ \033[1;33mepm tool erc x \033[0m<arch>\033[0m                │ Распаковать архив в текущую директорию         │\n"
printf "│ \033[1;33mepm tool erc formats\033[0m                 │ Поддерживаемые форматы архивов                 │\n"
printf "└──────────────────────────────────────┴────────────────────────────────────────────────┘\n"
echo

echo "\033[1;36mHTTP запросы\033[0m"
echo "Инструмент для загрузки файлов с поддержкой подстановочных знаков (*) в именах файлов."
echo 
echo "Поддерживаемые URL-протоколы:"
echo "ftp:// http:// https:// file:/ ipfs://"
echo 
echo "Поддерживаемые движки загрузки (можно задать через переменную EGET_BACKEND=curl):"
echo "wget curl"

printf "┌──────────────────────────────────────┬────────────────────────────────────────────────┐\n"
printf "│ \033[1;33mКоманда epm\033[0m                          │ \033[1;37mОписание\033[0m                                       │\n"
printf "├──────────────────────────────────────┼────────────────────────────────────────────────┤\n"
printf "│ \033[1;33mepm tool eget \033[0m<url>      \033[0m            │ Скачать пакет по ссылке                        │\n"
printf "│ \033[1;33mepm tool eget \033[0m<url/pkg*> \033[0m            │ Скачать все пакеты по шаблону pkg*             │\n"
printf "│ \033[1;33mepm tool eget -P \033[0m<path> <url>  \033[0m      │ Скачать пакет в директорию                     │\n"
printf "│ \033[1;33mepm tool eget --allow-mirrors \033[0m<url>\033[0m  │ Скачать через альтернативные зеркала           │\n"
printf "│ \033[1;33mepm tool eget --check-url \033[0m<url>\033[0m      │ Проверить, существует ли пакет                 │\n"
printf "│ \033[1;33mepm tool eget --check-site \033[0m<url>\033[0m     │ Проверить доступность сайта                    │\n"
printf "│ \033[1;33mepm tool eget --get-response \033[0m<url>\033[0m   │ Вывести заголовки ответа сервера               │\n"
printf "│ \033[1;33mepm tool eget --list \033[0m<url/pkg*>\033[0m      │ Вывести доступные версии пакета                │\n"
printf "└──────────────────────────────────────┴────────────────────────────────────────────────┘\n"
echo

echo -e "\033[1;36mСодержимое файлов\033[0m"
printf "┌──────────────────────────────────────┬────────────────────────────────────────────────┐\n"
printf "│ \033[1;33mКоманда epm\033[0m                          │ \033[1;37mОписание\033[0m                                       │\n"
printf "├──────────────────────────────────────┼────────────────────────────────────────────────┤\n"
printf "│ \033[1;33mepm tool ercat\033[0m <file>\033[0m                │ Просмотреть содержимое файла                   │\n"
printf "└──────────────────────────────────────┴────────────────────────────────────────────────┘\n"
echo
}


EOF
)

add_to_file() {
  local file="$1"

  # Проверка, есть ли уже функция
  if grep -q "eepm-help()" "$file"; then
    echo "[INFO] eepm-help уже добавлен в $file"
  else
    echo -e "\n# Добавлено install_epm_aliases.sh" >> "$file"
    echo "$EPM_HELP_FUNC" >> "$file"
    echo "[OK] Добавлено в $file"
  fi
}

# Добавим в оба файла
add_to_file "$ZSHRC"
add_to_file "$BASHRC"

echo
echo "[INFO] Перезапусти терминал или выполни:"
echo "Если используешь zsh:"
echo "source ~/.zshrc"
echo "Если используешь bash:"
echo "source ~/.bashrc"
echo
