#!/bin/bash

# 🚀 Автоматичний скрипт оптимізації ZALIZO.STUDIO
# Використання: chmod +x optimize.sh && ./optimize.sh

set -e  # Зупинитися при помилці

echo "╔════════════════════════════════════════════╗"
echo "║  🚀 ZALIZO.STUDIO - Оптимізація сайту     ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# Кольори для виводу
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Перевірка необхідних інструментів
echo -e "${YELLOW}📋 Крок 1: Перевірка інструментів...${NC}"

check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $1 не встановлено. Встановлюю...${NC}"
        return 1
    else
        echo -e "${GREEN}✓ $1 встановлено${NC}"
        return 0
    fi
}

# Встановити Node.js інструменти
if ! check_tool svgo; then
    npm install -g svgo
fi

if ! check_tool cwebp; then
    echo -e "${YELLOW}⚠️  cwebp не знайдено. Встановіть libwebp-tools:${NC}"
    echo "sudo apt-get install webp"
fi

if ! check_tool ffmpeg; then
    echo -e "${YELLOW}⚠️  ffmpeg не знайдено. Встановіть ffmpeg:${NC}"
    echo "sudo apt-get install ffmpeg"
fi

echo ""
echo -e "${YELLOW}📁 Крок 2: Оптимізація SVG логотипу...${NC}"

cd "$(dirname "$0")"

# Оптимізувати SVG
if [ -f "Logo/Дизайн без назви.svg" ]; then
    ORIGINAL_SIZE=$(du -h "Logo/Дизайн без назви.svg" | cut -f1)
    echo "Оригінальний розмір: $ORIGINAL_SIZE"
    
    if command -v svgo &> /dev/null; then
        svgo "Logo/Дизайн без назви.svg" -o "Logo/logo-optimized.svg" \
            --multipass \
            --config='{ "plugins": [
                "removeDoctype",
                "removeXMLProcInst",
                "removeComments",
                "removeMetadata",
                "removeEditorsNSData",
                "cleanupAttrs",
                "mergeStyles",
                "inlineStyles",
                "minifyStyles",
                "cleanupIds",
                "removeUselessDefs",
                "cleanupNumericValues",
                "convertColors",
                "removeUnknownsAndDefaults",
                "removeNonInheritableGroupAttrs",
                "removeUselessStrokeAndFill",
                "removeViewBox",
                "cleanupEnableBackground",
                "removeHiddenElems",
                "removeEmptyText",
                "convertShapeToPath",
                "convertEllipseToCircle",
                "moveElemsAttrsToGroup",
                "moveGroupAttrsToElems",
                "collapseGroups",
                "convertPathData",
                "convertTransform",
                "removeEmptyAttrs",
                "removeEmptyContainers",
                "mergePaths",
                "removeUnusedNS",
                "sortAttrs",
                "sortDefsChildren",
                "removeTitle",
                "removeDesc"
            ]}'
        
        NEW_SIZE=$(du -h "Logo/logo-optimized.svg" | cut -f1)
        echo -e "${GREEN}✓ Оптимізовано! Новий розмір: $NEW_SIZE${NC}"
        
        # Створити резервну копію
        cp "Logo/Дизайн без назви.svg" "Logo/Дизайн без назви.svg.backup"
        echo -e "${GREEN}✓ Резервна копія створена: Logo/Дизайн без назви.svg.backup${NC}"
    else
        echo -e "${RED}❌ SVGO не встановлено. Пропускаю оптимізацію SVG${NC}"
    fi
else
    echo -e "${RED}❌ Файл Logo/Дизайн без назви.svg не знайдено${NC}"
fi

echo ""
echo -e "${YELLOW}📸 Крок 3: Оптимізація зображень...${NC}"

# Оптимізувати WebP зображення
if command -v cwebp &> /dev/null && [ -d "Photos" ]; then
    mkdir -p Photos/optimized
    
    for file in Photos/*.webp; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            ORIGINAL=$(du -h "$file" | cut -f1)
            
            cwebp -q 82 -m 6 "$file" -o "Photos/optimized/$filename"
            
            NEW=$(du -h "Photos/optimized/$filename" | cut -f1)
            echo -e "${GREEN}✓ $filename: $ORIGINAL → $NEW${NC}"
        fi
    done
    
    echo -e "${GREEN}✓ Оптимізовані зображення збережені в Photos/optimized/${NC}"
else
    echo -e "${YELLOW}⚠️  Пропускаю оптимізацію WebP (cwebp не встановлено або Photos не існує)${NC}"
fi

echo ""
echo -e "${YELLOW}🎬 Крок 4: Оптимізація відео...${NC}"

if command -v ffmpeg &> /dev/null && [ -d "Video" ]; then
    mkdir -p Video/optimized
    
    # Desktop відео
    if [ -f "Video/Video_with_Metal_Gates.mp4" ]; then
        echo "Оптимізація desktop відео..."
        ORIGINAL=$(du -h "Video/Video_with_Metal_Gates.mp4" | cut -f1)
        
        ffmpeg -i "Video/Video_with_Metal_Gates.mp4" \
            -vcodec libx264 \
            -crf 28 \
            -preset slow \
            -vf "scale=1920:-2" \
            -an \
            -movflags +faststart \
            "Video/optimized/Video_with_Metal_Gates.mp4" \
            -y -loglevel error
        
        NEW=$(du -h "Video/optimized/Video_with_Metal_Gates.mp4" | cut -f1)
        echo -e "${GREEN}✓ Desktop відео: $ORIGINAL → $NEW${NC}"
    fi
    
    # Mobile відео
    MOBILE_VIDEO=$(find Video -name "*KlickPin*" -o -name "*Home Tour*" | head -1)
    if [ -n "$MOBILE_VIDEO" ]; then
        echo "Оптимізація mobile відео..."
        ORIGINAL=$(du -h "$MOBILE_VIDEO" | cut -f1)
        
        ffmpeg -i "$MOBILE_VIDEO" \
            -vcodec libx264 \
            -crf 30 \
            -preset slow \
            -vf "scale=1080:-2" \
            -an \
            -movflags +faststart \
            "Video/optimized/mobile_video.mp4" \
            -y -loglevel error
        
        NEW=$(du -h "Video/optimized/mobile_video.mp4" | cut -f1)
        echo -e "${GREEN}✓ Mobile відео: $ORIGINAL → $NEW${NC}"
    fi
    
    echo -e "${GREEN}✓ Оптимізовані відео збережені в Video/optimized/${NC}"
else
    echo -e "${YELLOW}⚠️  Пропускаю оптимізацію відео (ffmpeg не встановлено або Video не існує)${NC}"
fi

echo ""
echo -e "${YELLOW}📊 Крок 5: Статистика...${NC}"

echo ""
echo "Розміри директорій:"
echo "Logo:   $(du -sh Logo 2>/dev/null | cut -f1)"
echo "Photos: $(du -sh Photos 2>/dev/null | cut -f1)"
echo "Video:  $(du -sh Video 2>/dev/null | cut -f1)"
echo ""

if [ -d "Photos/optimized" ]; then
    echo "Photos optimized: $(du -sh Photos/optimized 2>/dev/null | cut -f1)"
fi

if [ -d "Video/optimized" ]; then
    echo "Video optimized:  $(du -sh Video/optimized 2>/dev/null | cut -f1)"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ Оптимізація завершена!                ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}📝 Наступні кроки:${NC}"
echo "1. Перевірте оптимізовані файли в директоріях */optimized/"
echo "2. Оновіть шляхи в index.html на оптимізовані версії"
echo "3. Запустіть Lighthouse для перевірки покращення"
echo ""
echo -e "${YELLOW}💡 Команда для швидкої заміни файлів:${NC}"
echo ""
echo "# Замінити SVG логотип:"
echo "mv Logo/logo-optimized.svg \"Logo/Дизайн без назви.svg\""
echo ""
echo "# Замінити зображення:"
echo "mv Photos/optimized/*.webp Photos/"
echo ""
echo "# Замінити відео:"
echo "mv Video/optimized/Video_with_Metal_Gates.mp4 Video/"
echo "mv Video/optimized/mobile_video.mp4 \"Video/From KlickPin CF Pin by LyfairsAvery on Home Tour [Video] in 2025 _ Design your dream house Big houses interior House design.mp4\""
echo ""
echo -e "${GREEN}✨ Гарного дня!${NC}"
