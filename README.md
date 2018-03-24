
# MarkGate

a very simple Oh-My-ZSH Plugin to mark Directories With Autocompletion for exist marks

## INSTALATION

```sh
git clone https://github.com/zakariaGatter/MarkGate ~/.oh-my-zsh/custom/plugins/markgate
```

### Add MarkGate Plugin to ~.zshrc

---

```sh
plugins=(... markgate ... )
```

#### Usage

---

* [X] : **Add Mark**

```sh
 cd ~/.oh-my-zsh/custom/plugins/markgate
 markadd markgate
```

or

``` sh
markadd makgate ~/.oh-my-zsh/custom/plugins/markgate
```

* [X] : **Remove Mark**
```sh
markdel markgate
```

* [X] : **Jumb to Mark**
```sh
markjumb markgate
```
* [X] : **Show Marks**

 ```sh
markshow
 ```

### Settings

---

To Specific **MarkGate** Config File Add this line to your ```~/.zshrc```

> MARKGATE_FILE="Name_of_file"

default Config File :

* MARKGATE_FILE="markgate"


 Config File is always on this Directorie `~/.$MARKGATE_FILE`

### [!] Notes

If You Found any issues or have new ideos please send me a mail to :

**Gmail :**

``` bash
zakaria.gatter@gmail.com

```

#### You may like 

 * [Powergate Theme](https://github.com/zakariaGatter/Powergate)
 * [MarkEdit](https://github.com/zakariaGatter/MarkEdit)
