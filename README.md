
# MarkGate

a very simple **Bash** **Zsh**  Plugin to mark Directories With Autocompletion for exist marks

[![asciicast](https://asciinema.org/a/1vT0VaYFveXzKwlM94rs6871P.png)](https://asciinema.org/a/1vT0VaYFveXzKwlM94rs6871P)

## INSTALATION

```sh
git clone https://github.com/zakariaGatter/MarkGate /path/to/markgate/markgate.sh
```

### Add MarkGate Plugin to ~.zshrc or ~/.bashrc

---

```sh
source /path/to/markgate/markgate.sh
```

### Help

```
    MARK GATE (29/04/2018)
    Written by Zakaria Barkouk (zakaria.gatter@gmail.com)

    Mark your directory's for Easy Access

OPTS    :       
        ga          Add Mark Directory
        gr          Remove Mark Directory 
        gs          Show All Mark Directory's
        gj          Jumb To mark Directory

EXAMPLE :   
        ga home     ( add 'home' Mark to corrent Directory)
        ga home ~   ( Add 'home' Mark to /home/gatter Directory)
        gj home     ( Jumb to 'home' Mark)
        gr home     ( Delete 'home' Mark and suport multi Delete )

File    :   DIR_GATE=~/.config/dir_file
```

#### Usage

---

* [X] : **Add Mark**

```sh
cd /path/to/markgate
ga markgate
```

or

``` sh
ga makgate /path/to/markgate
```

* [X] : **Remove Mark**
```sh
gr markgate _(multi mark remove)_
```

* [X] : **Jumb to Mark**
```sh
gj markgate
```
* [X] : **Show Marks**

 ```sh
gs
 ```

### Support 

   * [Fiverr](https://www.fiverr.com/zakariagatter)
   * [Donate](https://www.paypal.me/ZGatter)

### Notes

If You Found any issues or have new ideos please send me a mail to :

**Gmail :**

``` bash
zakaria.gatter@gmail.com

```

#### You may like 

 * [Powergate Theme](https://github.com/zakariaGatter/Powergate)
 * [MarkEdit](https://github.com/zakariaGatter/MarkEdit)
 * [i3blocks-Gate](https://github.com/zakariaGatter/i3blocks-gate)
