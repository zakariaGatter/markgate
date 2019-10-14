# MarkGate


## Table of Contents 

- [About](#about)
- [Usage](#usage)
- [Installation](#installation)
- [Help](#help)

## About

[MarkGate] Is a very simple (Bash/Zsh) Plugin to mark Directories With Auto completion for exist marks

[MarkGate] allow you to ...

* Mark directory's
* Jump to marked directory 
* Delete a Mark
* Edit exist Mark

---

## Usage

* **Add Mark**

```sh
cd /path/to/markgate
ga markgate
```

or

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

* **Edit Marks**
```sh
ge markgate
```

---

## INSTALLATION

```sh
git clone https://gitlab.com/zakariagatter/markgate /path/to/markgate
```

#### Add MarkGate Plugin to ~./zshrc or ~/.bashrc

```sh
source /path/to/markgate/markgate.sh
```

---

### Help

```
    MARK GATE (29/04/2018)
    Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

    Mark your directory's for Easy Access

OPTS    :       
        ga          Add Mark Directory
        gr          Remove Mark Directory 
        gs          Show All Mark Directory's
        gj          Jump To mark Directory
        ge          Change or Edit Exist mark

EXAMPLE :   
        ga home     ( add 'home' Mark to current Directory)
        ga home ~   ( Add 'home' Mark to /home/gatter Directory)
        gj home     ( Jumb to 'home' Mark)
        gr home     ( Delete 'home' Mark and support multi Delete )
        gs          ( Show all mark in your System )
        ge home     (Edit or Change Mark name or Directory)

```
