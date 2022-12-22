# План доклада

* Опредение продолжения
* Пример на StreamAPI
* Пример без StreamAPI
* Передачи продолжений как часть ФП
* Позитивные моменты спп
* Негативные моменты спп
* Фичи в языках
* Замыкания
  * Пример со слайда
  * Ссылки `1_closures/bin/link.dart`
  * Шахматы `1_closures/bin/chest.dart`
  * Мемоизация `1_closures/bin/memoise.dart`
  * Концептуальный пример на питоне `2_cps-concept/example.py`
* Функции как объекты
  * Фреймворк и обработчики `3_express-server/src/index.ts` (рассказ про обработчики)
  * Обработчики на фронте `3_express-server/static/script.js` (обработчики на фронте)
  * Мидлвэры `3_express-server/src/middleware.ts` (рассказ про мидлверы)
  * Промисы `4_my-future/src/index.ts` (промисы)
* Перерыв на мемы
* Генераторы
  * Генераторы - магия `5_generator_example/bin/sync/vanila.dart`
  * Генераторы - это не магия `5_generator_example/bin/sync/range_iterable.dart`
  * Применение генераторов `6_linq_example/linq/linq_api.py`
  * Перерыв на мемы
  * Асинхронные генераторы `5_generator_example/bin/async/vanila.dart`
  * Чтение и мгновенная обработка из файла и `observer` `5_generator_example/bin/async/read_file.dart`
  * Применение стримов и генераторов в архитектурных паттернах мобильной разработки
    * Лирическое отступление: `widget flutter`
    * Архитектурный паттерн `bloc` + `7_stream_example/lib/bloc/example/`
    * Визуальный осмотр туду листа
    * Улучшенная реализация `7_stream_example/lib/bloc/base`
    * Как работать с блоком на примере туду листа? (создать экран, выписать ивенты, отдавать состояния)
    * Конкретный блок для туду листа `7_stream_example/lib/models/todo_list/bloc`
    * Примеры посыла ивента с верстки `7_stream_example/lib/views/todo_widget.dart` `7_stream_example/lib/views/todo_filter_switch_widget.dart`
    * Пример применения синхронного генератора для фильтрации `7_stream_example/lib/models/todo_list/todo_filter`
    * Пример реагирования на ивенты в верстке `7_stream_example/lib/views/todo_list_screen.dart`
* Заключение
  * Тема обширная
  * Фичи с СПП применяются повсеместно
