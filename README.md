## custom_worldgen - небольшой фреймворк для кастомной генерации миров 

### Установка

Для установки перекиньте склонируйте репозиторий в папку `custom_worldgen` в 
папке с контент-паками. Для подключения фреймворка используйте следующее:

```lua
require "customworldgen:main"
```

### Документация

```lua
customworldgen.get_cords_by_chunk(chunk_x: int, chunk_z: int) -> int, int, int, int
```

Принимает координаты чанка. Возвращает две пары координат x, z - углы чанка.

```lua
customworldgen.get_chunk_by_cords(x: int, y: int) -> int, int, 
```

Возвращает координаты чанка по координатам.

```lua
customworldgen.register_generator(generator: function)
```

Регистрирует функцию, генерирующую мир (далее функция-генератор).
Функция-генератор принимает два аргумента - `chunk_x: int, chunk_z: int` - 
координаты чанка.

#### Параметры

```lua
customworldgen.params["generation_rate"] -- Количество тиков которые пройдут перед следующей генерацией
customworldgen.params["generation_radius"] -- Радиус в котором будут генерироваться чанки
```
