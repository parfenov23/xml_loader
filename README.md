# Настройка и запуск кода

1) Склонировать репозиторий: 
```
git clone git@github.com:parfenov23/xml_loader.git
```
2) Перейти в папку проекта:
```
cd xml_loader
```
3) Запустить: 
```bundle```
4) создать базу: 
```
rake db:create
```
5) запустить миграцию: 
```
rake db:migrate
```
6) скачать файл xml -> https://yadi.sk/d/bDU6ZJ7LSSSQIA
7) распаковать файл и закинуть в папку public
8) запустить console
```
railc c
```
9) запустить код:
```
require "catalog_filter"
parser = Nokogiri::XML::SAX::Parser.new(CatalogFilter.new)
parser.parse(File.open("#{Rails.root}/public/example.xml"))
```
