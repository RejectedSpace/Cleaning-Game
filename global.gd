extends Node

var cur_scene: Node3D
var save_path = "N:/Save/cleaningGame.save"
var saveData
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
var furnitureDictionary: Dictionary
var visitedHogwarts: bool
var hasKey: bool
var paused

func _ready() -> void:
	pass

func save():
	saveData = []
	for node in cur_scene.find_child("House").get_children():
		if(node is GrabbableObject):
			saveData.append(node.get_data())
	saveData.append(cur_scene.find_child("Player").get_data())
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(trashCleaned)
	file.store_var(furnitureCleaned)
	file.store_var(totalFurniture)
	file.store_var(furniturePlaced)
	file.store_var(spillsCleaned)
	file.store_var(spillsCleanedDictionary)
	file.store_var(stainsCleanedDictionary)
	file.store_var(furnitureDictionary)
	file.store_var(visitedHogwarts)
	file.store_var(hasKey)
	file.store_var(saveData)
	file.close()

func load_data():
	totalFurnitureStains = 0
	totalSpills = 0
	totalTrash = 0
	if data_exists():
		var file = FileAccess.open(save_path,FileAccess.READ)
		trashCleaned=file.get_var(true)
		furnitureCleaned=file.get_var(true)
		totalFurniture= file.get_var(true)
		furniturePlaced= file.get_var(true)
		spillsCleaned = file.get_var(true)
		spillsCleanedDictionary = file.get_var(true)
		stainsCleanedDictionary = file.get_var(true)
		furnitureDictionary = file.get_var(true)
		visitedHogwarts = file.get_var(true)
		hasKey=file.get_var(true)
		saveData=file.get_var(true)
		var i = 0
		for node in cur_scene.find_child("House").get_children():
			if(node is GrabbableObject):
				node.load_data(saveData[i])
				i+=1
		cur_scene.find_child("Player").load_data(saveData[i])
		file.close()

func data_exists():
	return FileAccess.file_exists(save_path)
