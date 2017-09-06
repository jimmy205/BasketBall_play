# 籃球場資訊交換APP #

## 發想起源 ##
### 1.時常到了籃球場，發現半個人都沒有！ ###
### 2.時常到了籃球場，發現場地被借走！ ###
### 3.時常到了籃球場，發現場地破舊不堪！ ###
### 4.所以就開發了一個可以找籃球場，順便提供揪人打球以及場地使用狀況的APP！ ###



## 用途 ##

### 1.提供籃球場地查詢，並即時資訊交換 ###
### 2.可以約人打球 ###
### 3.即時回報場地狀況，提供場地目前的使用狀況及人數 ###

## 開發過程 ##

### 1.使用體育署的OpenData API串接，讀取JSON資料 ###
### 2.將讀取到的JSON資料整理，依照使用者的目前位置依序排列 ###
### 3.撰寫PHP，將每個留言儲存於MySql。並於需要時呼叫留言版資訊 ###
### 4.加入APPLE MAP 導航系統，提供使用者導航至目的地 ###
### 開發工具及語言：Php、MySQL、Swift、XCODE ###

## 使用方式 ##

### 進入後會以TableView的形式顯示球場的資訊 ###
![alt text](https://github.com/jimmy205/jimmy205.github.io/blob/master/play_together/playground_list.png)

### 點選有興趣的球場即可進入留言版，查看或輸入留言 ###
![alt text](https://github.com/jimmy205/jimmy205.github.io/blob/master/play_together/board.png)

### 點選導航，可使用Apple Map導航至球場位置 ###
![alt text](https://github.com/jimmy205/jimmy205.github.io/blob/master/play_together/apple_map.png)

