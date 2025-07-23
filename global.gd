extends Node

var save_path = "user://cleaningGame.save"
var totalTrash: int
var trashCleaned: int
var furnitureCleaned: int
var totalFurnitureStains: int
var totalFurniture: int
var furniturePlaced: int
var spillsCleaned: int
var totalSpills: int
var spillsCleanedDictionary: Dictionary
var stainsCleanedDictionary: Dictionary
var positionsDictionary: Dictionary
var rotationsDictionary: Dictionary
var furnitureDictionary: Dictionary
var trashDictionary: Dictionary
var visitedHogwarts: bool
var hasKey: bool
var paused

func _ready() -> void:
	load_data()

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(totalTrash)
	file.store_var(trashCleaned)
	file.store_var(furnitureCleaned)
	file.store_var(totalFurnitureStains)
	file.store_var(totalFurniture)
	file.store_var(furniturePlaced)
	file.store_var(spillsCleaned)
	file.store_var(totalSpills)
	file.store_var(spillsCleanedDictionary)
	file.store_var(stainsCleanedDictionary)
	file.store_var(positionsDictionary)
	file.store_var(rotationsDictionary)
	file.store_var(furnitureDictionary)
	file.store_var(trashDictionary)
	file.store_var(visitedHogwarts)
	file.store_var(hasKey)

func load_data():
	if data_exists():
		var file = FileAccess.open(save_path,FileAccess.READ)
		totalTrash = file.get_var(true)
		trashCleaned=file.get_var(true)
		furnitureCleaned=file.get_var(true)
		totalFurnitureStains= file.get_var(true)
		totalFurniture= file.get_var(true)
		furniturePlaced= file.get_var(true)
		spillsCleaned = file.get_var(true)
		totalSpills = file.get_var(true)
		spillsCleanedDictionary = file.get_var(true)
		stainsCleanedDictionary = file.get_var(true)
		positionsDictionary = file.get_var(true)
		rotationsDictionary = file.get_var(true)
		furnitureDictionary = file.get_var(true)
		trashDictionary=file.get_var(true)
		visitedHogwarts = file.get_var(true)
		hasKey=file.get_var(true)

func data_exists():
	return FileAccess.file_exists(save_path)
