# MarkGate


## Table of Contents

- [About](#about)
- [Usage](#usage)
- [Installation](#installation)
- [Help](#help)

## About

[MarkGate] Is a very simple (Zsh) Plugin to mark Directories With Auto completion for exist marks

[MarkGate] allow you to ...

* Mark directory's
* Jump to marked directory
* Delete a Mark
* Display list of marks

---

## Usage

* **Add Mark**

```sh
ga makgate /path/to/markgate
```

* **Remove Mark**
```sh
gr markgate (multi mark remove)
```

* **Jump to Mark**
```sh
gj markgate
```

* **Show Marks**
```sh
gs
```

---

## INSTALLATION

```sh
git clone https://github.com/zakariagatter/markgate /path/to/markgate
```

#### Add MarkGate Plugin to ~./zshrc

```sh
source /path/to/markgate/markgate.sh
```

---

### Help

```
MarkGate: Mark your Directories for easy access

FUNCTION:
ga <name> <DIR>   Add new mark to Markgate
gj <name>         Jumb to giving mark
gr <name> ...     Remove one or multi Marks
gs <name> ...     Display list of marks
gh                Show this help dialog

```

### Note

This Plugin is complete. If there is any modifications in the future, they will be just syntax improving. (Thank you all for using **Markgate**)
