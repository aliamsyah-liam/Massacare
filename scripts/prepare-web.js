// Menyalin three.js (r128) dari node_modules ke www/ agar game jalan offline di dalam APK.
const fs = require('fs'), path = require('path');
const src = path.join(__dirname, '..', 'node_modules', 'three', 'build', 'three.min.js');
const dst = path.join(__dirname, '..', 'www', 'three.min.js');
if (!fs.existsSync(src)) { console.error('three.min.js tidak ditemukan. Jalankan "npm install" dulu.'); process.exit(1); }
fs.copyFileSync(src, dst);
console.log('three.min.js disalin ke www/');
