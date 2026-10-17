#!/usr/bin/env bash
# Dijalankan setelah "npx cap add android": layar landscape penuh, tetap menyala, izinkan koneksi ws://
set -e
A=android/app/src/main
MAN=$A/AndroidManifest.xml
STY=$A/res/values/styles.xml

# Landscape (mengikuti sensor) + tidak restart saat rotasi
sed -i 's|<activity|<activity android:screenOrientation="sensorLandscape"|' "$MAN"
# Izinkan lalu lintas ws:// (server LAN/tanpa HTTPS)
grep -q usesCleartextTraffic "$MAN" || sed -i 's|<application|<application android:usesCleartextTraffic="true"|' "$MAN"

# Layar penuh, tanpa status bar, mengisi area poni
python3 - "$STY" <<'PY'
import sys,re
p=sys.argv[1];s=open(p,encoding='utf8').read()
add='''
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
        <item name="android:keepScreenOn">true</item>'''
s=re.sub(r'(<style name="AppTheme.NoActionBar"[^>]*>)',lambda m:m.group(1)+add,s,count=1)
open(p,'w',encoding='utf8').write(s)
PY
echo "Patch Android selesai"
