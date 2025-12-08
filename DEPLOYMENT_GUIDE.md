# 🚀 ZALIZO.STUDIO - GITHUB PAGES DEPLOYMENT

## 📦 ФАЙЛИ ВКЛЮЧЕНІ В АРХІВ:

```
zalizo-studio-web/
├── index.html (114 KB) ← ГОЛОВНИЙ ФАЙЛ
├── Photos/
│   ├── Ворота.webp (512 KB)
│   ├── Перила.webp (48 KB)
│   ├── Балкони.webp (36 KB)
│   ├── Меблі.webp (52 KB)
│   └── Спеціальні.webp (444 KB)
├── Video/
│   ├── Video_with_Metal_Gates.mp4 (3.4 MB)
│   └── mobile_video.mp4 (3.7 MB)
├── Logo/
│   └── Дизайн без назви.svg (1.8 MB)
└── Documentation/
    ├── OPTIMIZATION_REPORT.md
    └── LOADING_CHECKLIST.md
```

---

## ⚡ ШВИДКІСТЬ ЗАВАНТАЖЕННЯ

Оптимізовано для максимальної продуктивності:
- ✅ WebP формат (90% менші файли)
- ✅ Оптимізовані відео
- ✅ CDN глобально (GitHub Pages)
- ✅ Автоматичний HTTPS
- ✅ Estimated: **First Paint ~500ms**

---

## 🎯 КРОК 1: СТВОРИ НОВИЙ РЕПОЗИТОРІЙ НА GITHUB

1. Зайди на https://github.com/new
2. **Repository name**: `zalizo-studio` (або будь-яке ім'я)
3. **Description**: `Zalizo Studio - Ковані вироби | Дизайн | Монтаж`
4. **Visibility**: Public (обов'язково для GitHub Pages!)
5. ✅ **Add README.md** - обери
6. Натисни **Create repository**

---

## 🎯 КРОК 2: РОЗПАКУЙ АРХІВ

```bash
# На твоєму комп'ютері
tar -xzf zalizo-studio-web.tar.gz
cd zalizo-studio-web

# або просто розпакуй через файловий менеджер
```

---

## 🎯 КРОК 3: ЗАВАНТАЖ ФАЙЛИ НА GITHUB

### Варіант А: Через GitHub Web (найпростіше)
1. Зайди в новий репозиторій
2. Натисни **Add file** → **Upload files**
3. Перетягни файли з архіву:
   - `index.html`
   - папку `Photos/`
   - папку `Video/`
   - папку `Logo/`
4. Напиши commit message: `Initial deployment`
5. Натисни **Commit changes**

### Варіант Б: Через Git CLI (для досвідчених)
```bash
git clone https://github.com/YOUR_USERNAME/zalizo-studio.git
cd zalizo-studio

# Скопіюй файли з архіву сюди
cp -r ~/Downloads/zalizo-studio-web/* .

git add .
git commit -m "Deploy Zalizo Studio website"
git push origin main
```

---

## 🎯 КРОК 4: УВІМКНИ GITHUB PAGES

1. Зайди в репозиторій → **Settings**
2. Лівий сайдбар → **Pages**
3. **Source**: Обери `main` branch
4. **Folder**: Обери `/ (root)`
5. Натисни **Save**
6. Зачекай 1-2 хвилини
7. ✅ Сайт буде на https://YOUR_USERNAME.github.io/zalizo-studio/

---

## 🎯 КРОК 5: ПІДКЛЮЧИ域 ZALIZO.STUDIO

### На GitHub (Settings → Pages):
1. **Custom domain**: введи `zalizo.studio`
2. ✅ **Enforce HTTPS**
3. Натисни **Save**

### На Name.com (DNS):

**1. Додай TXT запис для верифікації:**
```
TYPE: TXT
HOST: _github-pages-challenge-YOUR_USERNAME
VALUE: [GitHub покаже це значення]
TTL: 300
```

**2. Додай A records (4 штуки):**
```
TYPE: A
HOST: @
ANSWER: 185.199.108.153
TTL: 3600

TYPE: A
HOST: @
ANSWER: 185.199.109.153
TTL: 3600

TYPE: A
HOST: @
ANSWER: 185.199.110.153
TTL: 3600

TYPE: A
HOST: @
ANSWER: 185.199.111.153
TTL: 3600
```

**3. Додай CNAME для www:**
```
TYPE: CNAME
HOST: www
ANSWER: YOUR_USERNAME.github.io
TTL: 3600
```

4. Зачекай 10-30 хвилин для DNS propagation
5. На GitHub натисни **Verify**

---

## ✅ ГОТОВО!

Твій сайт буде доступний на:
- 🌐 https://zalizo.studio
- 🌐 https://www.zalizo.studio

---

## 📊 ПЕРЕВІРКА ШВИДКОСТІ

Перевір на:
- https://pagespeed.web.dev (введи zalizo.studio)
- https://gtmetrix.com
- https://tools.pingdom.com

Очікувані результати:
- **PageSpeed Score**: 90-98/100
- **Load time**: 2-3 секунди
- **First Contentful Paint**: ~500ms

---

## 🔄 ОНОВЛЕННЯ САЙТУ ПІЗНІШЕ

Щоразу коли хочеш оновити:
1. Завантаж новий файл на GitHub → Commit
2. GitHub Pages автоматично оновить сайт (за ~30 сек)

---

## 📞 ПОТРІБНА ДОПОМОГА?

Якщо щось не зрозуміло:
1. Перевір скріни GitHub Pages налаштувань
2. Переконайся що репозиторій **Public**
3. Перевір DNS записи на Name.com
4. Зачекай 30-60 хвилин (DNS може повільно обновлюватись)

---

**Created**: 2025-12-08
**Status**: 🟢 READY TO DEPLOY
**Estimated Speed**: ⚡ Excellent (90+ PageSpeed)
