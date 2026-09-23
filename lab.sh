#!/bin/bash

cd ~

mkdir lab0
cd lab0

mkdir claude_monet
mkdir claude_monet/pastry_station
mkdir claude_monet/pastry_station/oven
mkdir claude_monet/pastry_station/cold_room
mkdir claude_monet/hall
mkdir claude_monet/office
mkdir louis_room
mkdir empty_boxes

touch claude_monet/pastry_station/oven/croissant_plan
touch claude_monet/pastry_station/oven/millefeuille_plan
touch claude_monet/pastry_station/cold_room/cream_note
touch claude_monet/pastry_station/dessert_menu
touch claude_monet/hall/banquet_orders
touch claude_monet/hall/guest_wishes
touch claude_monet/office/barinov_comment
touch louis_room/louis_diary
touch louis_room/work_schedule
touch morning_order

cat > claude_monet/pastry_station/oven/croissant_plan <<'EOF'
Луи замешивает тесто ранним утром
Круассаны должны быть готовы к открытию
В первую партию добавить миндальный крем
Баринов проверит выпечку лично
EOF

cat > claude_monet/pastry_station/oven/millefeuille_plan <<'EOF'
Коржи для мильфея выпекаются отдельно
Луи готовит ванильный крем
Десерт украсят свежими ягодами
Первую порцию подадут Виктору Петровичу
EOF

cat > claude_monet/pastry_station/cold_room/cream_note <<'EOF'
Сливочный крем хранится в холодной комнате
Шоколадный крем нужен для банкета
Луи подписывает каждую ёмкость
Остатки проверяет Лёва после смены
EOF

cat > claude_monet/pastry_station/dessert_menu <<'EOF'
Классический круассан с миндалём
Мильфей с ванильным кремом
Шоколадный торт от Луи
Фирменный десерт Claude Monet
EOF

cat > claude_monet/hall/banquet_orders <<'EOF'
Для банкета приготовить двадцать круассанов
На главный стол подать шоколадный десерт
Гости ждут торт к девятнадцати часам
Вика просит проверить каждый заказ
EOF

cat > claude_monet/hall/guest_wishes <<'EOF'
Постоянный гость просит десерт без орехов
За седьмым столиком ждут мильфей
Детям приготовить небольшие круассаны
Один гость хочет познакомиться с Луи
EOF

cat > claude_monet/office/barinov_comment <<'EOF'
Баринов требует уменьшить количество сахара
Крем должен быть приготовлен перед подачей
Луи отвечает за оформление десертов
Новое меню показать шефу до обеда
EOF

cat > louis_room/louis_diary <<'EOF'
Луи пришёл в кондитерский цех первым
Утром он приготовил любимый десерт Нагиева
После банкета Луи позвонил маме
Вечером весь зал похвалил его торт
EOF

cat > louis_room/work_schedule <<'EOF'
Луи начинает работу в семь часов
До открытия нужно проверить печь
После обеда начинается подготовка банкета
Закрывает кондитерский цех Лёва
EOF

cat > morning_order <<'EOF'
К открытию подготовить свежую выпечку
Вика ждёт список готовых десертов
Баринов проводит проверку в десять часов
Луи передаёт первый заказ официантам
EOF

chmod 755 claude_monet
chmod 750 claude_monet/pastry_station/oven
chmod 640 claude_monet/pastry_station/oven/millefeuille_plan
chmod 600 claude_monet/pastry_station/cold_room/cream_note
chmod 755 claude_monet/hall
chmod 644 claude_monet/hall/guest_wishes
chmod 750 claude_monet/office
chmod 640 claude_monet/office/barinov_comment
chmod 750 louis_room
chmod 644 louis_room/work_schedule
chmod 644 morning_order

chmod u=rwx,g=rx,o= claude_monet/pastry_station
chmod u=rwx,g=rx,o= claude_monet/pastry_station/cold_room
chmod u=rw,g=r,o= claude_monet/pastry_station/oven/croissant_plan
chmod u=rw,g=rw,o=r claude_monet/hall/banquet_orders
chmod u=r,g=r,o= louis_room/louis_diary
chmod u=rwx,g=,o= empty_boxes

pwd
ls -lR

git status
git add .
git commit -m "Создана начальная структура лабораторной работы"

git remote add origin https://github.com/Mikh08/lab0.git
git push -u origin master

cp louis_room/louis_diary claude_monet/office/confectioner_report
cp -r claude_monet/hall claude_monet/pastry_station/hall_backup
ln -s ../claude_monet/pastry_station/dessert_menu louis_room/today_menu
ln -s claude_monet/pastry_station dessert_counter
ln morning_order claude_monet/pastry_station/urgent_order

cat claude_monet/pastry_station/oven/croissant_plan \
    claude_monet/pastry_station/oven/millefeuille_plan \
    > claude_monet/pastry_station/baking_plan

cat claude_monet/office/barinov_comment >> claude_monet/pastry_station/dessert_menu

mv claude_monet/hall/guest_wishes claude_monet/office/special_wishes

ls -lR
ls -l louis_room/today_menu
ls -l dessert_counter
ls -l morning_order claude_monet/pastry_station/urgent_order

git init
git status
git add .
git commit -m "Создана начальная структура лабораторной работы"

ls -lR | grep '^-' | grep -v 'report' | sort -k5n | tail -n 5

grep -rihE 'луи|десерт' claude_monet louis_room \
    | grep -iv 'гост' \
    | sort -r \
    | head -n 5

grep -ril 'десерт' \
    claude_monet/hall \
    claude_monet/pastry_station/hall_backup \
    | wc -l

tail -n 2 claude_monet/pastry_station/oven/*_plan \
    | grep -v '^==>' \
    | grep -iE 'десерт|порц' \
    | sort

grep -v 'Луи' claude_monet/pastry_station/baking_plan \
    | sort -r \
    | head -n 4 \
    | wc -w

ls -lR \
    | grep '^-[rwx-]\{9\} 2 ' \
    | sort -k9r

ls -lR \
    | grep '^l' \
    | sort -k9 \
    | tail -n 1

rm louis_room/louis_diary
rm louis_room/today_menu
rm dessert_counter
rm morning_order
rm claude_monet/pastry_station/urgent_order
rm claude_monet/pastry_station/cold_room/cream_note
rmdir empty_boxes
rm -r claude_monet/pastry_station/hall_backup

pwd
ls -lR
git status

git add .
git status
git commit -m "Выполнены операции с файлами и каталогами"
git status
git log --oneline
git show --stat --oneline HEAD
