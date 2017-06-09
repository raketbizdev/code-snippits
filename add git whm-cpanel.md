### How to enable git to WHM
```
$ ln -s /usr/local/cpanel/3rdparty/bin/git /usr/local/bin/git
```
### How to enable git in cpanel

1. Open Cpanel  via Terminal
```
$ nano .bashrc
```
2. Add this code.
```
$ alias git="/usr/local/cpanel/3rdparty/bin/git"
```
3. Save and close `.bashrc`
4. Run `.bashrc`
```
$ source ~/.bashrc
```
5. Test if git properly install by running
```
$ git
```
