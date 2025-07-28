#!/bin/bash

# Opravený skript na bezpečné odstránenie starých jadier

set -e

echo "=== Odstránenie starých jadier ==="

# Aktuálne bežiace jadro (s prefixom linux-image-)
CURRENT_KERNEL="linux-image-$(uname -r)"
echo "Aktuálne spustené jadro: $CURRENT_KERNEL"

# Zoznam nainštalovaných jadier, zotriedený od najstaršieho po najnovšie
INSTALLED_KERNELS=$(dpkg --list | grep '^ii' | grep 'linux-image-[0-9]' | awk '{print $2}' | sort -V)

echo "Nájdené jadrá:"
echo "$INSTALLED_KERNELS"

# Ponechať 2 najnovšie jadrá + aktuálne jadro
KERNELS_TO_KEEP=$(echo "$INSTALLED_KERNELS" | tail -n 2)
KERNELS_TO_KEEP="$KERNELS_TO_KEEP"$'\n'"$CURRENT_KERNEL"

# Odstráň duplikáty a zoraď
KERNELS_TO_KEEP=$(echo "$KERNELS_TO_KEEP" | sort -u)

echo "Ponechávame tieto jadrá:"
echo "$KERNELS_TO_KEEP"

# Vyber staré jadrá (všetky okrem ponechaných)
KERNELS_TO_REMOVE=$(comm -23 <(echo "$INSTALLED_KERNELS" | sort -u) <(echo "$KERNELS_TO_KEEP" | sort -u))

if [ -z "$KERNELS_TO_REMOVE" ]; then
    echo "✅ Žiadne staré jadrá na odstránenie."
    exit 0
fi

echo "Odstránime tieto staré jadrá:"
echo "$KERNELS_TO_REMOVE"

# Odstránenie starých jadier
for KERNEL_PKG in $KERNELS_TO_REMOVE; do
    echo "🗑️ Odstraňujem jadro: $KERNEL_PKG"
    sudo apt remove --purge -y "$KERNEL_PKG"
done

# Aktualizácia grub
echo "🔄 Aktualizujem GRUB..."
sudo update-grub

echo "✅ Hotovo. Staré jadrá boli odstránené."
