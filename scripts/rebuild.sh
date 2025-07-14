#!/bin/bash

# script de rebuild pour SavvyCAN
# Usage : ./scripts/rebuild.sh

echo "🔥 Cleaning previous build..."
rm -rf cmake-build-debug

echo "📁 Creating build directory..."
mkdir cmake-build-debug
cd cmake-build-debug

echo "⚙️ Running cmake..."
cmake ..

echo "🚀 Building with make..."
make -j$(sysctl -n hw.ncpu)

echo "✅ Build complete."

echo "▶️ Launching the app..."
../bin/SavvyCAN