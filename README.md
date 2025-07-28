# 🧹 clean_old_kernels.sh

Skript na **bezpečné a automatizované odstránenie starých jadier** v Ubuntu (testované na Kubuntu 20.04 LTS).  
Uvoľní miesto na disku tým, že ponechá **aktuálne bežiace jadro** a **2 najnovšie nainštalované jadrá**, pričom ostatné odstráni.

A script to **safely and automatically remove old kernels** in Ubuntu (tested on Kubuntu 20.04 LTS).
Frees up disk space by keeping the **current running kernel** and the **2 most recently installed kernels**, while removing the others.

---

## 🔍 Čo skript robí

1. Zistí aktuálne bežiace jadro (`uname -r`).
2. Zozbiera všetky nainštalované balíky jadier (`linux-image-*`).
3. Ponechá aktuálne jadro a 2 najnovšie nainštalované.
4. Odstráni všetky ostatné staré jadrá pomocou `apt remove --purge`.
5. Na záver aktualizuje GRUB (`sudo update-grub`).

---

## 💡 Prečo to používať?

Staré jadrá môžu zaberať stovky MB až niekoľko GB na `/boot`, čo môže spôsobiť:
- Nefunkčnosť aktualizácií systému (nedostatok miesta),
- Varovania pri inštalácii nových balíkov,
- Zbytočne zaplnený disk.

---

## ⚠️ Upozornenie

Používaj **na vlastné riziko** – aj keď je skript opatrný, odporúčame mať vždy zálohu systému alebo spustiť najprv nasucho:

```bash
bash clean_old_kernels.sh  # pre kontrolu výstupu
```

## 🛠️ Spustenie

`chmod +x clean_old_kernels.sh`

`./clean_old_kernels.sh`


## ✅ Overené na

   Ubuntu 20.04 LTS (Focal Fossa)

   Skript nevyžaduje žiadne externé závislosti, používa len štandardné príkazy (`dpkg`, `apt`, `grep`, `sort`, `comm`, ...)

## 📄 Licencia

MIT License – voľne použiteľné, upraviteľné a zdieľateľné.

## 🤝 Príspevky

Ak máš nápady na zlepšenie (napr. podpora iných distribúcií alebo suchý režim `--dry-run`), neváhaj otvoriť pull request alebo issue.
