weblabor.hu-box-puppet
======================

weblabor.hu vagrant box puppet-el felhúzva. Egyben minden, amit igény
esetén lehet darabolni. 

Hozzávalók beszerzése (Vagrant, Puppet):

https://www.vagrantup.com/downloads.html

```shell
sudo apt-get install puppet
```

A weblabor.hu repo (jelenleg svn) a weblabor.hu könyvtárba húzandó le.

Végül:

Sima felhasználóként a Vagrantfile könyvtárában:
```shell
vagrant up
```

hosts fájlba (tetszőleges domain névvel):
```shell
192.168.3.10 	weblabor.dev
```