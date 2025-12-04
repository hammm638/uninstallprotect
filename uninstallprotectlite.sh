#!/bin/bash

echo "===================================="
echo "   UNINSTALL PROTECT PANEL LITE"
echo "   REMOVE BY @Humannnceko"
echo "===================================="

# Lokasi panel
PANEL_DIR="/var/www/pterodactyl"
MW_DIR="$PANEL_DIR/app/Http/Middleware"
MW_FILE="$MW_DIR/AntiIntipMiddleware.php"
KERNEL_FILE="$PANEL_DIR/app/Http/Kernel.php"
ROUTE_FILE="$PANEL_DIR/routes/server.php"

echo "[1] Menghapus file AntiIntipMiddleware..."
if [ -f "$MW_FILE" ]; then
    rm -f "$MW_FILE"
    echo "   → Dihapus!"
else
    echo "   → File tidak ditemukan (mungkin sudah dihapus)"
fi

echo "[2] Menghapus register middleware dari Kernel.php..."
sed -i "/'anti.intip' => \\\\Pterodactyl\\\\Http\\\\Middleware\\\\AntiIntipMiddleware::class,/d" "$KERNEL_FILE"

echo "[3] Mengembalikan middleware route server..."
# Kembalikan menjadi hanya auth
sed -i "s/middleware(['auth','anti.intip']);/middleware('auth');/g" "$ROUTE_FILE"

echo "[4] Fix permission kembali normal..."
chown -R www-data:www-data $PANEL_DIR
chmod -R 755 $PANEL_DIR

echo "[5] Restart layanan panel..."
systemctl restart pteroq >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1

echo
echo "===================================="
echo " UNINSTALL PROTECT LITE SELESAI!"
echo " Protect anti-intip berhasil dihapus!"
echo "===================================="